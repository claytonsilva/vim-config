return {
  { "nvim-neotest/neotest-plenary" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-plenary",
        "neotest-go",
        "rustaceanvim.neotest",
        "neotest-python",
      },
    },
  },
}
