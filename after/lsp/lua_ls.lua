return {
    settings = {
        Lua = {
            -- Define runtime properties. Use 'LuaJIT', as it is built into Neovim.
            runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
            workspace = {
                -- Don't analyze code from submodules
                ignoreSubmodules = true,
                -- Add Neovim's methods for easier code writing
                library = { vim.env.VIMRUNTIME },
            },
        },
    },
}
