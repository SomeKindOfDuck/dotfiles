return {
  "kylechui/nvim-surround",
  event = "VeryLazy",
  config = function()
    require("nvim-surround").setup({
      surrounds = {
        ["("] = {
          add = { "(", ")" },
        },
        ["["] = {
          add = { "[", "]" },
        },
        ["{"] = {
          add = { "{", "}" },
        },
      }
    })
  end
}
