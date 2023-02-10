describe("indent_line", function()
  it("indents lines correctly", function()
    local text = "some text"
    local indented_text = require("refactor.string_utils").indent_line(text, 2)
    local expected = "  " .. text
    assert.are.same(expected, indented_text)
  end)
  it("does not indent on no indentation", function()
    local text = "some text"
    local indented_text = require("refactor.string_utils").indent_line(text, 0)
    local expected = text
    assert.are.same(expected, indented_text)
  end)
end)
