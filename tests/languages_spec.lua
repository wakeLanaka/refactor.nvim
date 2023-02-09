describe("print_keyword", function()
  it("returns correct print for scala", function()
    local keyword = require("refactor.languages").print_keyword["scala"]
    assert.are.same(keyword, "println")
  end)
  it("returns correct print for lua", function()
    local keyword = require("refactor.languages").print_keyword["lua"]
    assert.are.same(keyword, "print")
  end)
  it("returns correct print for javascript", function()
    local keyword = require("refactor.languages").print_keyword["javascript"]
    assert.are.same(keyword, "console.log")
  end)
end)

describe("comment_keyword", function()
  it("returns correct comments for scala", function()
    local keyword = require("refactor.languages").comment_keyword["scala"]
    assert.are.same(keyword, "//")
  end)
  it("returns correct comments for lua", function()
    local keyword = require("refactor.languages").comment_keyword["lua"]
    assert.are.same(keyword, "--")
  end)
  it("returns correct comments for javascript", function()
    local keyword = require("refactor.languages").comment_keyword["javascript"]
    assert.are.same(keyword, "//")
  end)
end)
