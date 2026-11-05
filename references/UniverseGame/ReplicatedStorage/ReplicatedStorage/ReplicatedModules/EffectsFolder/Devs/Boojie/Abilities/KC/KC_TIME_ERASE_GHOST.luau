  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
game:GetService("RunService");
local Ghost = require(script:WaitForChild("Ghost"));
local u1 = {};

local function Update(u2, p3) -- Line: 10
    -- upvalues: u1 (copy), Ghost (copy)
    local u4 = u1[u2];

    if p3 then
        if not u4 then
            u4 = Ghost.new(u2);
            u4.Janitor:Connect(u2.AncestryChanged, function() -- Line: 15
                -- upvalues: u2 (copy), u4 (ref)
                if not u2:IsDescendantOf(workspace) then
                    u4:Destroy();
                end;
            end);
            u1[u2] = u4;
        end;

        if not u4.Next then
            u4:Cast(p3);
        end;

        u4.Next = p3;
    elseif u4 then
        u4:Destroy();
        u1[u2] = nil;
    end;
end;

game:GetService("RunService").RenderStepped:Connect(function(p5) -- Line: 35
    -- upvalues: u1 (copy)
    for i, v in u1 do
        if v.Next then
            if v.GhostCharacter:FindFirstChild("HumanoidRootPart") then
                local CFrame2 = v.GhostCharacter.HumanoidRootPart.CFrame;
                local Next = v.Next;

                if i:FindFirstChild("HumanoidRootPart") then
                    Next = CFrame.new(Next.Position.X, i.HumanoidRootPart.Position.Y, Next.Position.Z);
                end;

                v:Cast((CFrame2:Lerp(Next, p5 * 24)));
            else
                u1[i] = nil;
            end;
        end;
    end;
end);

return function(p6) -- Line: 59
    -- upvalues: Update (copy), u1 (copy)
    if typeof(p6) == "table" then
        for _, v in pairs(p6) do
            local v7, v8 = unpack(v);
            Update(v7, v8);
        end;

        return;
    end;

    if p6 == false then
        for i, _ in pairs(u1) do
            local v9 = u1[i];

            if v9 then
                v9:Destroy();
                u1[i] = nil;
            end;
        end;
    end;
end;