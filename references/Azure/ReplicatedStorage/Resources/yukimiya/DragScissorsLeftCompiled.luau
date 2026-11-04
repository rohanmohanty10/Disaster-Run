 
 

local function emit(...) -- Line: 1
    if shared.vfx and shared.vfx.emit then
        shared.vfx.emit(...);

        return;
    end;

    require(game.ReplicatedStorage.util.vfxUtil).emitAll(...);
end;

return {
    { 0, function(p1) -- Line: 12
            -- upvalues: emit (copy)
            emit(p1.Ball.Attachment, p1.Ball:FindFirstChild("Attachment"), p1.Ball.ink);
        end },
    { 21, function(p2) -- Line: 17
            -- upvalues: emit (copy)
            emit(p2.HumanoidRootPart["2"]);
            emit(p2.HumanoidRootPart["1"]);
        end },
    { 37, function(p3) -- Line: 23
            -- upvalues: emit (copy)
            emit(p3.HumanoidRootPart["2.5"]);
        end },
    { 45, function(p4) -- Line: 28
            -- upvalues: emit (copy)
            emit(p4.HumanoidRootPart["3"]);
            emit(p4.HumanoidRootPart.f30Enabled);
            emit(p4.Ball.Attachment, p4.Ball:FindFirstChild("Attachment"), p4.Ball.ink);
        end }
};