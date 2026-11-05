  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = game:GetService("RunService"):IsStudio();
local traceback = debug.traceback;
local u2 = {
    Assets = {
        ["Lightning Spear"] = ReplicatedStorage["Client Assets"].Locke["Meshes/LightningSpear2"]
    }
};

function u2.FetchAsset(p3) -- Line: 12
    -- upvalues: u2 (copy), u1 (copy), traceback (copy)
    if not u2.Assets[p3] and u1 then
        warn(p3, traceback("not found in assets"));
    end;

    return u2.Assets[p3];
end;

function u2.AddAsset(p4, p5) -- Line: 20
    -- upvalues: u2 (copy), u1 (copy), traceback (copy)
    if u2.Assets[p4] or not p5 then
        if u1 then
            if u2.Assets[p4] then
                warn(p4, "asset already exists");
            end;

            if type(p5) ~= "userdata" then
                warn(p4, "invalid asset given");
            end;

            warn(traceback());
        end;

        return;
    end;

    u2.Assets[p4] = p5;
end;

function u2.UpdateAsset(p6, p7) -- Line: 36
    -- upvalues: u2 (copy), u1 (copy), traceback (copy)
    if u2.Assets[p6] and p7 then
        u2.Assets[p6] = p7;

        return;
    end;

    if u1 then
        if not u2.Assets[p6] then
            warn(p6, "cannot be updated since asset doesn\'t exist");
        end;

        if type(p7) ~= "userdata" then
            warn(p6, "cannot be updated since given asset is invalid");
        end;

        warn(traceback());
    end;
end;

function u2.RemoveAsset(p8) -- Line: 52
    -- upvalues: u2 (copy), u1 (copy), traceback (copy)
    if u2.Assets[p8] then
        u2.Assets[p8] = nil;

        return;
    end;

    if u1 then
        warn(p8, traceback("cannot be removed, not found in assets"));
    end;
end;

u2.GetAsset = u2.FetchAsset;
u2.DeleteAsset = u2.RemoveAsset;

return u2;