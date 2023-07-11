M = {}

M.handle_error = function(fn, error_message)
    return function()
        local ok = pcall(fn)
        if not ok then
            print(error_message)
        end
    end
end

return M
