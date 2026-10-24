return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local paths_to_check = { '/', '/../' }
      local cwd = vim.fn.getcwd()
      local godot_root = nil

      for _, value in pairs(paths_to_check) do
        if vim.uv.fs_stat(cwd .. value .. 'project.godot') then
          godot_root = vim.fn.fnamemodify(cwd .. value, ':p'):gsub('/$', '')
          break
        end
      end

      if not godot_root then return end

      if not vim.uv.fs_stat('/tmp/godot.pipe') then
        vim.fn.serverstart('/tmp/godot.pipe')
      end

      local port = os.getenv('GDScript_Port') or '6005'
      vim.lsp.config('gdscript', {
        cmd = vim.lsp.rpc.connect('127.0.0.1', tonumber(port)),
        filetypes = { 'gdscript' },
        root_markers = { 'project.godot', '.git' },
      })
      vim.lsp.enable('gdscript')

      -- Reusable scratch buffer that streams the game's stdout/stderr (print, errors).
      local output_buf = nil
      local job_id = nil

      -- Stop the running game; SIGTERM closes its window.
      local function stop_godot()
        if job_id and job_id > 0 then
          vim.fn.jobstop(job_id)
        end
      end

      local function get_output_win()
        if not (output_buf and vim.api.nvim_buf_is_valid(output_buf)) then
          output_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_buf_set_name(output_buf, 'Godot Output')
          vim.bo[output_buf].filetype = 'log'
          -- From within the output console, <esc> or q stops the game.
          vim.keymap.set('n', '<esc>', stop_godot, { buffer = output_buf, desc = 'Godot: stop game' })
          vim.keymap.set('n', 'q', stop_godot, { buffer = output_buf, desc = 'Godot: stop game' })
        end
        -- Reuse the window if the buffer is already visible, else open a bottom split.
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == output_buf then
            return win, output_buf
          end
        end
        vim.cmd('botright 12split')
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, output_buf)
        vim.wo[win].number = false
        vim.wo[win].relativenumber = false
        vim.cmd('wincmd p') -- keep focus in the editing window
        return win, output_buf
      end

      local function run_godot(args)
        local win, buf = get_output_win()
        vim.bo[buf].modifiable = true
        vim.api.nvim_buf_set_lines(buf, 0, -1, false, { '$ ' .. table.concat(args, ' '), '' })

        local function append(_, data)
          if not data or not vim.api.nvim_buf_is_valid(buf) then return end
          -- jobstart splits on newlines; the first chunk continues the last buffer line.
          local last = vim.api.nvim_buf_get_lines(buf, -2, -1, false)[1] or ''
          local lines = { last .. data[1] }
          for i = 2, #data do lines[#lines + 1] = data[i] end
          vim.api.nvim_buf_set_lines(buf, -2, -1, false, lines)
          if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
            vim.api.nvim_win_set_cursor(win, { vim.api.nvim_buf_line_count(buf), 0 })
          end
        end

        job_id = vim.fn.jobstart(args, {
          on_stdout = append,
          on_stderr = append,
          on_exit = function(id, code)
            if job_id == id then job_id = nil end
            if vim.api.nvim_buf_is_valid(buf) then
              vim.api.nvim_buf_set_lines(buf, -1, -1, false,
                { '', '[godot exited with code ' .. code .. ']' })
            end
          end,
        })
      end

      -- Run the game (main scene), independent of the running editor.
      vim.api.nvim_create_user_command('GodotRun', function()
        run_godot({ 'godot', '--path', godot_root })
      end, { desc = 'Run the Godot project (main scene)' })

      -- Run the scene matching the current file (player.gd -> player.tscn).
      vim.api.nvim_create_user_command('GodotRunScene', function()
        local scene = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':r') .. '.tscn'
        if not vim.uv.fs_stat(scene) then
          vim.notify('Godot: no matching scene ' .. scene, vim.log.levels.ERROR)
          return
        end
        run_godot({ 'godot', '--path', godot_root, scene })
      end, { desc = 'Run the scene matching the current file' })

      -- Open the Godot editor for this project.
      vim.api.nvim_create_user_command('GodotEditor', function()
        vim.fn.jobstart({ 'godot', '-e', '--path', godot_root }, { detach = true })
      end, { desc = 'Open the Godot editor' })

      -- Open the online class reference for a class name (arg or word under cursor).
      vim.api.nvim_create_user_command('GodotDocs', function(opts)
        local name = opts.args ~= '' and opts.args or vim.fn.expand('<cword>')
        if name == '' then
          vim.notify('Godot: no class name under cursor', vim.log.levels.WARN)
          return
        end
        vim.ui.open('https://docs.godotengine.org/en/stable/classes/class_'
          .. name:lower() .. '.html')
      end, { nargs = '?', desc = 'Open the Godot class reference in a browser' })

      vim.api.nvim_create_user_command('GodotStop', stop_godot,
        { desc = 'Stop the running Godot game' })

      vim.keymap.set('n', '<leader>gr', '<cmd>GodotRun<cr>', { desc = 'Godot: run game' })
      vim.keymap.set('n', '<leader>grs', '<cmd>GodotRunScene<cr>', { desc = 'Godot: run scene' })
      vim.keymap.set('n', '<leader>gk', stop_godot, { desc = 'Godot: stop game' })
    end,
  }
}
