describe("get_print_keyword", function()
  it("returns correct keyword for scala", function()
    local keyword = require("refactor.languages").print_keyword["scala"]
    assert.are.same(keyword, "println")
  end)
  it("returns correct keyword for lua", function()
    local keyword = require("refactor.languages").print_keyword["lua"]
    assert.are.same(keyword, "print")
  end)
  it("returns correct keyword for javascript", function()
    local keyword = require("refactor.languages").print_keyword["javascript"]
    assert.are.same(keyword, "console.log")
  end)
end)
