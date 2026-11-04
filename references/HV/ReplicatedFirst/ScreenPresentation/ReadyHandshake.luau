 

 

local u1 = {};
u1.__index = u1;

function u1.new(p2, p3, p4) -- Line: 4
    -- upvalues: u1 (copy)
    local v5 = p4 or {};

    return setmetatable({
        player = p2,
        alive = p3 or function() -- Line: 8
            return true;
        end,
        spawn = v5.spawn or task.spawn,
        wait = v5.wait or task.wait,
        remote = v5.remote or function() -- Line: 13
            local ChickenOrHero = game.ReplicatedStorage:FindFirstChild("ChickenOrHero");

            if ChickenOrHero then
                ChickenOrHero = ChickenOrHero:FindFirstChild("Game");
            end;

            if ChickenOrHero then
                ChickenOrHero = ChickenOrHero:FindFirstChild("PlayerPreferences");
            end;

            return ChickenOrHero;
        end
    }, u1);
end;

function u1.run(u6) -- Line: 20
    if u6.running then
        return;
    end;

    u6.running = true;
    u6.spawn(function() -- Line: 25
        -- upvalues: u6 (copy)
        while u6.alive() and u6.player.Parent do
            local u7 = u6.completeRequested and u6.player:GetAttribute("ClientReady") ~= true;
            local u8 = u6.transferRequested and u6.player:GetAttribute("TransferReady") ~= true;

            if not (u7 or u8) then
                break;
            end;

            pcall(function() -- Line: 32
                -- upvalues: u6 (ref), u8 (copy), u7 (copy)
                local v9 = u6.remote();

                if v9 then
                    if u8 then
                        v9:FireServer("TransferReady");
                    end;

                    if u7 then
                        v9:FireServer("Ready");
                    end;
                end;
            end);
            u6.wait(2);
        end;

        u6.running = false;
    end);
end;

function u1.complete(p10) -- Line: 48
    p10.completeRequested = true;
    p10:run();
end;

function u1.transferReady(p11) -- Line: 52
    p11.transferRequested = true;
    p11:run();
end;

return u1;