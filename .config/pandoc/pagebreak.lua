local pagebreak = pandoc.RawBlock("latex", "\\newpage")

function Pandoc(doc)
    local blocks = {}

    for i, block in ipairs(doc.blocks) do
        if block.t == "HorizontalRule" then
            table.insert(blocks, pagebreak)
        else
            table.insert(blocks, block)
        end
    end

    return pandoc.Pandoc(blocks, doc.meta)
end
