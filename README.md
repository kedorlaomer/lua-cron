# A cron demon in Lua

The module `cron` exports a single function `cron` that
implements a cron scheduler. It receives two arguments,
`entries` and `verbose`. `entries` is a list of cron jobs,
specified as a table with fields `callback` (a function that is
called without arguments when the job is run) and a set of
constraints:

* `weekday` (0..6, Sunday is 0)
* `hour` (0..23)
* `minute` (0..59)
* `day` (1..31)
* `month` (1..12)

Constrains can contain ranges `5-7` and enumerations `1-2,5`.

An unconstrained job runs every minute.

Don't do funny things as e. g. constraints that never become
true.

## Example

```lua

cron = require "cron"

job1 = {
    callback = function()
        print "Going to work…"
    end,
    hour = "9"
    minute = "15",
    day = "1-5"
}

job2 = {
    callback = function()
        print "Yoga classes"
    end,
    hour = "18",
    minute = "30",
    day = "1,4,7"
}

cron.cron{job1, job2}
```

## Requirements

*   [Luaposix](http://luaforge.net/projects/luaposix/)
*   granularity of `os.time` has to be at least seconds
*   for testing: [Luaunit](http://luaforge.net/projects/luaunit/)
