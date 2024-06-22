--[[
    I'm still learning how to make lua obfuscator :)

    Note: My code are not open source so even you managed to cracked this shit the actual code was obfuscated so fuck off and get the fuck out of here.
]]

return(
    function(GEnv, Unpack, ...)
        local function C()
            return {
                {
                    "http_request",
                    "http",
                    "syn",
                    "loadstring"
                }, {
                	"request",
                    "Url",
                    "Method",
                    "Headers",
                    "Body",
                    "https://raw.githubusercontent.com/ItsJiDy/Overdrive-H/main/Games/mm2.lua"
                },
                {}
            }
        end
        local function Wrap(Chunk, Ext, Env)
            local Proto = Chunk[1]
            local Constants = Chunk[2]
            local Stacks = Chunk[3]
            local Line = Ext[1] or 1
            local Enum = Ext[2] or 1
            return function(...)
                local Args = { ... }
                local Vm = 1
                local Save
                if Line == 1 then
                    Stacks[Enum] = Env[Constants[Enum]]
                    Stacks[Enum] = Stacks[Rev] or Env[Proto[Enum]]
                    Enum = Enum + 1
                    Stacks[Vm] = Stacks[Vm] or Env[Proto[Enum]] and Stacks[Vm] and Stacks[Vm][Constants[Vm]]
                    Enum = Enum + 1
                    Stacks[Vm] = Stacks[Vm] or Env[Proto[Enum]] and Stacks[Vm][Constants[Vm]]
                    if not Stacks[Vm] then
                        return
                    end
                    local Rev = {{Proto, Constants, Stacks}, {2,1}, Env}
                    Stacks[Enum] = Wrap(Unpack(Rev))
                    Save = Enum
                    Vm = Vm + 1
                    Stacks[Vm] = Stacks[Save](Constants[6])
                    if Stacks[Vm] and Stacks[Vm][Constants[5]] then
                        Save = Vm
                        Vm = Vm + 1
                        Enum = Enum + 1
                        Stacks[Vm] = Env[Proto[Enum]]
                        Stacks[Vm+1] = Stacks[Vm](Stacks[Save][Constants[5]])
                        Vm = Vm + 1
                        Stacks[Vm](Unpack({ ... }))
                    end
                elseif Line == 2 then
                    local Rev = {}
                    Enum = Enum + 1
                    Rev[Constants[Enum]] = Args[Vm] or ""
                    Enum = Enum + 1
                    Rev[Constants[Enum]] = Args[2] or "GET"
                    Enum = Enum + 1
                    Rev[Constants[Enum]] = Args[3] or {}
                    Enum = Enum + 1
                    Rev[Constants[Enum]] = Args[4] or ""
                    if Rev then
                        return Stacks[Vm](Rev)
                    end
                end
            end
        end
        return Wrap(C(), {}, GEnv())()
    end
)(getfenv or function() return _ENV end, unpack or table.unpack, ...)