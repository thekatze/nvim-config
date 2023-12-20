return {
    -- TODO: add https://github.com/nvim-telescope/telescope-dap.nvim
    -- TODO: check how to set up for rust dev here https://github.com/simrat39/rust-tools.nvim
    --       or here https://www.youtube.com/watch?v=Mccy6wuq3JE&list=PLep05UYkc6wTWlugE_9Lj6JlLpvSBbkZ_&index=5
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        {
            "mfussenegger/nvim-dap",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

        -- maybe use the functions keys instead, dont know how thats gonna be with the new keyboard
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
        vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })

        vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue / Launch" })

        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            mappings = {
                -- Use a table to apply multiple mappings
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            -- Use this to override mappings for specific elements
            element_mappings = {
                -- Example:
                -- stacks = {
                --   open = "<CR>",
                --   expand = "o",
                -- }
            },
            -- Expand lines larger than the window
            -- Requires >= 0.7
            expand_lines = vim.fn.has("nvim-0.7") == 1,
            -- Layouts define sections of the screen to place windows.
            -- The position can be "left", "right", "top" or "bottom".
            -- The size specifies the height/width depending on position. It can be an Int
            -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
            -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
            -- Elements are the elements shown in the layout (in order).
            -- Layouts are opened in order so that earlier layouts take priority in window sizing.
            layouts = {
                {
                    elements = {
                        -- Elements can be strings or table with id and size keys.
                        { id = "scopes", size = 0.25 },
                        "breakpoints",
                        "stacks",
                        "watches",
                    },
                    size = 40, -- 40 columns
                    position = "left",
                },
                {
                    elements = {
                        "repl",
                        "console",
                    },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
            },
            controls = {
                -- Requires Neovim nightly (or 0.8 when released)
                enabled = true,
                -- Display controls in this element
                element = "repl",
                icons = {
                    pause = "",
                    play = "",
                    step_into = "",
                    step_over = "",
                    step_out = "",
                    step_back = "",
                    run_last = "↻",
                    terminate = "□",
                },
            },
            floating = {
                max_height = nil,  -- These can be integers or a float between 0 and 1.
                max_width = nil,   -- Floats will be treated as percentage of your screen.
                border = "single", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil, -- Can be integer or nil.
                max_value_lines = 100, -- Can be integer or nil.
            }
        })

        dap.listeners.after.event_initialized["launch-dap-ui"] = function()
            dapui.open();
        end

        dap.listeners.after.event_exited["launch-dap-ui"] = function()
            dapui.close();
        end

        dap.listeners.after.event_terminated["launch-dap-ui"] = function()
            dapui.close();
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
                command = "/usr/local/codelldb/adapter/codelldb",
                args = { "--port", "${port}" }
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
