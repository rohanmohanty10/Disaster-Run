 

 

local Players = game:GetService("Players");
local u1 = {};
u1.__index = u1;
local u2 = {};
local u3 = 0;

local function request(u4, p5) -- Line: 6
    -- upvalues: u2 (copy), u3 (ref), Players (copy)
    local v6 = u2[u4];

    if v6 and v6.image then
        p5(v6.image);

        return;
    end;

    if v6 and v6.pending then
        table.insert(v6.waiters, p5);

        return;
    end;

    if v6 and os.clock() < v6.retryAt then
        return;
    end;

    if u3 >= 64 then
        table.clear(u2);
        u3 = 0;
    end;

    local u7 = {
        pending = true,
        retryAt = 0,
        waiters = { p5 }
    };
    u2[u4] = u7;
    u3 = u3 + 1;
    task.spawn(function() -- Line: 13
        -- upvalues: Players (ref), u4 (copy), u7 (ref)
        local v8 = nil;

        for i = 1, 3 do
            local v9, v10, v11 = pcall(Players.GetUserThumbnailAsync, Players, u4, Enum.ThumbnailType.AvatarBust, Enum.ThumbnailSize.Size180x180);

            if v9 and (v11 and (type(v10) == "string" and v10 ~= "")) then
                v8 = v10;
                break;
            end;

            local v12;

            if i < 3 then
                task.wait(i * 0.5);
                v12 = i;
            else
                v12 = i;
            end;
        end;

        u7.pending = false;
        u7.image = v8;
        u7.retryAt = os.clock() + 30;

        for _, v in u7.waiters do
            v(v8);
        end;

        table.clear(u7.waiters);
    end);
end;

function u1.new() -- Line: 25
    -- upvalues: u1 (copy)
    return setmetatable({
        alive = true,
        tokens = {}
    }, u1);
end;

function u1.bind(u13, u14, p15) -- Line: 28
    -- upvalues: request (copy)
    local u16 = {};
    u13.tokens[u14] = u16;
    local Portrait = u14.Portrait;
    local AvatarFallback = u14.AvatarFallback;
    Portrait.Image = "";
    Portrait.Visible = false;
    AvatarFallback.Visible = p15 ~= nil;

    if not p15 then
        return;
    end;

    local Avatar = AvatarFallback:FindFirstChild("Avatar");

    if Avatar then
        for _, child in Avatar:GetChildren() do
            if child:IsA("BasePart") then
                local v17 = p15.avatarColors and p15.avatarColors[child.Name];
                local Attribute = child:GetAttribute("DefaultColor");
                child.Color = v17 and Color3.fromRGB(v17[1], v17[2], v17[3]) or (Attribute or child.Color);
            end;
        end;
    end;

    local v18 = p15.avatarUserId or not p15.isBot and p15.userId;

    if type(v18) ~= "number" or v18 <= 0 then
        return;
    end;

    request(v18, function(p19) -- Line: 45
        -- upvalues: u13 (copy), u14 (copy), u16 (copy), Portrait (copy), AvatarFallback (copy)
        if not (u13.alive and (u13.tokens[u14] == u16 and (u14.Parent and p19))) then
            return;
        end;

        Portrait.Image = p19;
        Portrait.Visible = true;
        AvatarFallback.Visible = false;
    end);
end;

function u1.clear(p20) -- Line: 50
    table.clear(p20.tokens);
end;

function u1.destroy(p21) -- Line: 51
    p21.alive = false;
    p21:clear();
end;

return u1;