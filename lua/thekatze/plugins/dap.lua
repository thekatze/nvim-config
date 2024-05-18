return {
    -- TODO: add https://github.com/nvim-telescope/telescope-dap.nvim
    -- TODO: check how to set up for rust dev here https://github.com/simrat39/rust-tools.nvim
    --       or here https://www.youtube.com/watch?v=Mccy6wuq3JE&list=PLep05UYkc6wTWlugE_9Lj6JlLpvSBbkZ_&index=5
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {}
            }
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        -- show rejected breakpoints clearly
        vim.fn.sign_define('DapBreakpointRejected', { text = '☹️', texthl = '', linehl = '', numhl = '' })

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

        -- maybe use the functions keys instead, dont know how thats gonna be with the new keyboard
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })

        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
        vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step back" })

        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Launch" })

        -- Eval var under cursor
        vim.keymap.set("n", "<space>ds", function()
            require("dapui").eval(nil, { enter = true })
        end, { desc = "Inspect symbol under cursor" })

        dapui.setup();

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        dap.adapters.coreclr = {
            type = 'executable',
            command = '/usr/local/netcoredbg',
            args = { '--interpreter=vscode' }
        }

        dap.configurations.cs = {
            {
                type = "coreclr",
                name = "launch - netcoredbg",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
                end,
            },
        }

        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}" }
            }
        }

        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            }
        }

        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/build/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            }
        }

        dap.configurations.rust = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            }
        }
    end,
}
