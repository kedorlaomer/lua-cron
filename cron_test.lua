luaunit = require "luaunit"
cron = require("cron").test

function test_enumerate_entry_single()
    tab = cron.enumerate_entry("5")
    luaunit.assertEquals(tab, {5})
end

function test_enumerate_entry_range()
    tab = cron.enumerate_entry("1-5")
    luaunit.assertEquals(tab, {1, 2, 3, 4, 5})
end

function test_enumerate_entry_list()
    tab = cron.enumerate_entry("7,8,5")
    luaunit.assertEquals(tab, {7, 8, 5})
end

function test_enumerate_entry_combined()
    tab = cron.enumerate_entry("1,5,11-13")
    expected = {1, 5, 11, 12, 13}
    luaunit.assertEquals(tab, expected)
end

function test_expand_list()
    list = cron.expand_list{4, 11, 17}
    expected = {}
    expected[4] = true
    expected[11] = true
    expected[17] = true
    luaunit.assertEquals(list, expected)
end

function test_parse_cronentry()
    entry = cron.parse_cronentry {
        weekday = "1-5",
        hour = "13,15",
        minute = "2",
        day = "17-19,1"
        -- month is unspecified
    }
    expected = {
        weekday = {true, true, true, true, true},
        hour = {[13]=true, [15]=true},
        minute = {[2]=true},
        day = {[1]=true, [17]=true, [18]=true, [19]=true},
        month = {true, true, true, true, true, true, true, true,
            true, true, true, true}
    }
    luaunit.assertEquals(entry, expected)
end

function test_match_cronentry_to_date()
    cronentry = cron.parse_cronentry {
        weekday = "3-4",
        hour = "12",
        minute = "1-18",
    }
    date = {
        weekday = 3,
        hour = 12,
        minute = 16,
        day = 4,
        month = 12
    }
    luaunit.assertTrue(cron.match_cronentry_with_date(cronentry, date))
    date.hour = 14
    luaunit.assertFalse(cron.match_cronentry_with_date(cronentry, date))
end

os.exit(luaunit.LuaUnit.run())
