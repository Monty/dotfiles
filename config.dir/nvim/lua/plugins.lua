return require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'neovim/nvim-lspconfig'
        use 'rktjmp/lush.nvim'
        use {
            'mcchrish/zenbones.nvim',
            requires = 'rktjmp/lush.nvim'
        }
        use 'RRethy/nvim-base16'
        use 'wuelnerdotexe/vim-enfocado'
        use 'themercorp/themer.lua'
        use {
            'norcalli/nvim-colorizer.lua',
            cmd = 'ColorizerToggle',
            config = function()
                require('colorizer').setup()
            end,
        }
        use {
            'lewis6991/gitsigns.nvim',
            config = function()
                require('gitsigns').setup {
                    signs = {
                        add          = { text = '+' },
                        change       = { text = '>' },
                        delete       = { show_count },
                        topdelete    = { show_count },
                        changedelete = { show_count },
                        untracked    = { text = '┆' },
                    }
                }
            end
        }
end)
