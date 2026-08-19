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
