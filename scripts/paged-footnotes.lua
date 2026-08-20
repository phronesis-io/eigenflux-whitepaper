local function render_note(blocks)
    local html = pandoc.write(pandoc.Pandoc(blocks), "html5")

    html = html:gsub("^%s*<p>", "")
    html = html:gsub("</p>%s*$", "")
    html = html:gsub("</p>%s*<p>", "<br><br>")

    return pandoc.RawInline(
        "html",
        '<span class="paged-footnote">' .. html .. "</span>"
    )
end

function Note(note)
    return render_note(note.content)
end

function Pandoc(doc)
    local series_number = pandoc.utils.stringify(doc.meta["series-number"])
    local last_rule = nil

    for index, block in ipairs(doc.blocks) do
        if block.t == "HorizontalRule" then
            last_rule = index
        end
    end

    if last_rule then
        local postscript_blocks = {}

        for index = last_rule, #doc.blocks do
            table.insert(postscript_blocks, doc.blocks[index])
        end

        for index = #doc.blocks, last_rule, -1 do
            table.remove(doc.blocks, index)
        end

        table.insert(doc.blocks, pandoc.Div(
            postscript_blocks,
            pandoc.Attr("", { "postscript" })
        ))
    end

    if series_number == "" then
        return doc
    end

    local series_label = pandoc.Div(
        pandoc.Plain({
            pandoc.Str("Research"),
            pandoc.Space(),
            pandoc.Str("Series"),
            pandoc.Space(),
            pandoc.Str("·"),
            pandoc.Space(),
            pandoc.Str(series_number),
        }),
        pandoc.Attr("", { "series-label" })
    )

    table.insert(doc.blocks, 1, series_label)
    return doc
end
