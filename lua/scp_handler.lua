local M = {}
local downloaded_files = {}

local function notify_progress(message)
    vim.schedule(function()
        vim.notify(message, vim.log.levels.INFO, { title = "SCP Progress" })
    end)
end

function M.handle_scp(uri)
    local username, host, port, path = uri:match("^scp://([^@]+)@([^:]+):?(%d*)/(.+)$")
    if not (username and host and path) then
        vim.api.nvim_err_writeln('Invalid SCP URI: ' .. uri)
        return
    end

    -- Use default port 22 if not provided
    if port == "" then
        port = "22"
    end

    -- Add a leading forward slash to the path
    path = '/' .. path

    -- Construct the scp command to download the file/directory
    local scp_command = string.format('scp -r -P %s %s@%s:%s /Users/macbook/remote_mount/', port, username, host, path)
    print("Executing SCP command:", scp_command)

    notify_progress("Downloading " .. path .. " from " .. host)

    -- Execute the scp command in the background
    vim.fn.jobstart(scp_command, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            for _, line in ipairs(data) do
                print(line)
            end
        end,
        on_stderr = function(_, data)
            for _, line in ipairs(data) do
                vim.api.nvim_err_writeln(line)
            end
        end,
        on_exit = function(_, exit_code)
            if exit_code == 0 then
                -- Track the downloaded file/directory
                local local_path = '/Users/macbook/remote_mount/' .. vim.fn.fnamemodify(path, ':t')
                table.insert(downloaded_files, local_path)

                -- Open the downloaded file/directory in the current buffer
                vim.schedule(function()
                    vim.cmd('e ' .. local_path)
                    -- Refresh Neo-tree to show the new file/directory
                    vim.cmd('Neotree close')
                    vim.cmd('Neotree show')
                    notify_progress("Download complete: " .. path)
                end)
            else
                vim.api.nvim_err_writeln("SCP command failed with exit code: " .. exit_code)
            end
        end,
    })
end

-- Function to remove all downloaded files/directories
function M.remove_files()
    for _, local_path in ipairs(downloaded_files) do
        local ok, err = vim.fn.delete(local_path, 'rf')
        if ok ~= 0 then
            print("Failed to remove file/directory:", err)
        else
            print("File/directory removed successfully:", local_path)
        end
    end
    -- Clear the list of downloaded files
    downloaded_files = {}
end

-- Register the VimLeave autocmd to delete all tracked files/directories upon exit
vim.cmd([[autocmd VimLeave * lua require('scp_handler').remove_files()]])

function M.setup_scp_handler()
    vim.api.nvim_create_autocmd({"BufReadCmd"}, {
        pattern = "scp://*",
        callback = function(args)
            M.handle_scp(args.file)
        end,
    })
end

return M
