local Module = {}
Module.ClassName = "PlayTween"

local TweenService = game:GetService("TweenService")

function Module:PlayTween(Inst, Info, ...)
    local Args = { ... }
    local Destination = {}
    local Meta = true
    for _ = 1, #Args do
        if Meta then
            local New = Args[_ + 1]
            if New then
                Destination[Args[_]] = New
            else
                error("Missing argument in #" .. _ + 1)
            end
            Meta = false
        else
            Meta = true
        end
    end
    local Tween = TweenService:Create(
        Inst,
        Info,
        Destination
    )
    Tween:Play()
    return Tween
end

return Module