#!/usr/bin/env lua
-- A compiler for Autocento of the breakfast table
-- written in Lua (because we can, and because
-- it's good practice for Functional Programming)
-- ((OR WHATEVER YOU CALL IT, GAHD))
-- vim: fdm=indent

dir = "/d/Copy/writing/autocento/"

function filterout (list, filter)
    local output = {}
    for _,v in ipairs(list) do
        if not string.match(v, filter) then
            -- table.insert Y U NO WORK?
            output[#output + 1] = v
        end
    end
    return output
end
function intable (table, item)
    for k,v in pairs(table) do
        if v == item then return k end
    end
    return false
end
function tabsub (table, pattern, replace)
    local output = {}
    for k,v in pairs(table) do
        output[k] = v:gsub(pattern, replace)
    end
    return output
end

function compile (files, output_fmt, extension, template, args)
    local errors = {}
    if template then table.insert(args, 'template="'..template..'"') end
    for _, file in pairs(files) do
        local pandoc_run = {
            'pandoc',
            '-f markdown',
            '-t '..output_fmt,
            table.concat(tabsub(args, "^", "--"), ' '),
            '-o '..file:gsub('^.*/(.-)%.%a+', '%1.'..extension),
            file
        }
        print("Compiling "..file.." to ".. extension)
        -- print(table.concat(pandoc_run, ' '))
        os.execute(table.concat(pandoc_run, ' '))
    end
end

function move (files, new_dir)
    local exe = {}
    for _,file in pairs(files) do
        print("Moving "..file.." to "..new_dir.."/ ..")
        table.insert(exe, 'mv '..file..' '..new_dir..'/')
    end
    os.execute(table.concat(exe, ' && '))
    -- print(table.concat(exe, '; '))
end

function lozenge (files)
    local output = 'var files=['
    for _,file in pairs(files) do
        output = output .. file:gsub('.*', '"%0",')
    end
    output = output:gsub(',$', ']')
    return output
end

local files = filterout(arg, '^%-')
if not files or #files == 0 then
    print("> No file list. WUT?")
    os.exit(1)
end
local args = filterout(arg, '^[^%-]')
if not args or #args == 0 or args == {'-all'} then
    args = {
        '-html',
        '-river',
        '-lozenge',
    }
end

if intable(args, '-html') then
    print("Compiling HTML ... ")
    compile(files, "html5", "html", ".template.html", {
        "smart",
        "mathml",
        "section-divs",
    })
    -- move(tabsub(files,'^.*/(.*)%.txt','%1.html'), ".")
end
if intable(args, '-river') then
    print("Compiling RIVER ... ")
    compile(files, "lua/river.lua", "river", nil, {})
    move(tabsub(files,'^.*/(.*)%.txt','%1.river'), "river")
end
if intable(args, '-lozenge') then
    print("Updating lozenge.js with file list ... ")
    -- TODO
end
