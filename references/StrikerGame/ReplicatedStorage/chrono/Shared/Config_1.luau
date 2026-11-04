 
 

require(script.Parent.Types);
local u1 = game:GetService("RunService"):IsServer();
local u2 = false;
local u3 = {
    __VERSION = "v2",
    CHECK_NEW_VERSION = true,
    MAX_TOTAL_BYTES_PER_FRAME_PER_PLAYER = 300,
    MIN_BUFFER = 0.09,
    MAX_BUFFER = 0.5,
    GRID_UPDATE_INTERVAL = 0.1,
    GRID_MAX_UPDATE_TIME = 0.0005,
    WARNING_SEVERITY = "MEDIUM",
    DEFAULT_NORMAL_TICK_DISTANCE = 50,
    DEFAULT_HALF_TICK_DISTANCE = 100,
    REPLICATE_DEATHS = "PLAYER_CHARACTERS",
    REPLICATE_CFRAME_SETTERS = "PLAYER_ENTITIES",
    PLAYER_REPLICATION = "AUTOMATIC",
    DEFAULT_INTERPOLATION_MODE = "CFRAME",
    DEFAULT_MODEL_REPLICATION_MODE = "NATIVE",
    MAX_SNAPSHOT_COUNT = 30
};
local u4 = {
    DEFAULT = {
        NAME = "DEFAULT",
        TICK_RATE = 0.05,
        BUFFER = 0.1
    },
    WITH_ROT = {
        NAME = "WITH_ROT",
        MODEL_REPLICATION_MODE = "NATIVE",
        BUFFER = 0,
        HALF_TICK_DISTANCE = (1 / 0),
        TICK_RATE = 0.05,
        ASSEMBLY_ROOT_PART_CHECK = true,
        FULL_ROTATION = true
    },
    PLAYER = {
        NAME = "PLAYER",
        MODEL_REPLICATION_MODE = "NATIVE",
        BUFFER = 0,
        HALF_TICK_DISTANCE = (1 / 0),
        TICK_RATE = 0.05,
        ASSEMBLY_ROOT_PART_CHECK = true
    }
};
local u5 = {};
local u6 = {};

local function GetEntityType(p7: string?) -- Line: 169
    -- upvalues: u4 (copy)
    return p7 and u4[p7] or u4.DEFAULT;
end;

local u8 = {};

return {
    SetConfig = function(p9, p10) -- Line: 164
        -- upvalues: u2 (ref), u3 (copy)
        assert(not u2, "Config is locked and cannot be modified after startup.");
        u3[p9] = p10;
    end,

    RegisterEntityType = function(p11: string, p12: any) -- Line: 143, Name: RegisterEntityType
        -- upvalues: u2 (ref), u4 (copy)
        assert(not u2, "Config is locked and cannot be modified after startup.");
        u4[p11] = p12;
    end,

    RegisterEntityModel = function(p13: string, p14: any, p15: vector?) -- Line: 156, Name: RegisterEntityModel
        -- upvalues: u5 (copy), u6 (copy)
        if p14 ~= false and (p14:IsA("Model") and not p14.PrimaryPart) then
            error(p13 .. " must have a PrimaryPart to be registered as an entity model.");
        end;

        u5[p13] = p14;
        u6[p13] = p15;
    end,

    FLAGS = {
        SERVER_VELOCITY_FIX = true,
        VELOCITY_CALC_FIX = true,
        SNAPSHOT_INTERPOLATION_FIX = true,
        SET_CFRAME_FIX = true,
        FIX_TELEPORT_JITTER = true
    },
    _EntityConfigs = u4,
    _GetEntityType = GetEntityType,
    GetEntityType = GetEntityType,

    _GetEntityModel = function(p16: string) -- Line: 173, Name: GetEntityModel
        -- upvalues: u5 (copy)
        if u5[p16] ~= nil then
            return u5[p16];
        end;

        warn((`Entity model {p16} not found in Config.`));

        return nil;
    end,

    _GetConfig = function(p17: string) -- Line: 185, Name: GetConfig
        -- upvalues: u3 (copy)
        return u3[p17];
    end,

    _Lock = function() -- Line: 205, Name: Lock
        -- upvalues: u2 (ref), u3 (copy), u4 (copy), u1 (copy), u8 (copy)
        require(script.Parent.Warn).low("Config is now locked");
        u2 = true;
        local DEFAULT_NORMAL_TICK_DISTANCE = u3.DEFAULT_NORMAL_TICK_DISTANCE;
        local DEFAULT_HALF_TICK_DISTANCE = u3.DEFAULT_HALF_TICK_DISTANCE;

        for i, v in u4 do
            local table_clone_ret = table.clone(v);
            table_clone_ret.NAME = i;
            table_clone_ret.AUTO_UPDATE_POSITION = table_clone_ret.AUTO_UPDATE_POSITION ~= false;
            table_clone_ret.FULL_ROTATION = table_clone_ret.FULL_ROTATION or false;
            table_clone_ret.NORMAL_TICK_DISTANCE = table_clone_ret.NORMAL_TICK_DISTANCE or DEFAULT_NORMAL_TICK_DISTANCE;
            table_clone_ret.HALF_TICK_DISTANCE = table_clone_ret.HALF_TICK_DISTANCE or DEFAULT_HALF_TICK_DISTANCE;
            table_clone_ret.MODEL_REPLICATION_MODE = table_clone_ret.MODEL_REPLICATION_MODE or u3.DEFAULT_MODEL_REPLICATION_MODE;
            table_clone_ret.INTERPOLATION_MODE = table_clone_ret.INTERPOLATION_MODE or u3.DEFAULT_INTERPOLATION_MODE;

            if u1 then
                table_clone_ret.TICKER = require(script.Parent.Ticker).new(table_clone_ret);
            else
                table_clone_ret.CLIENT_CLOCK = {};

                function table_clone_ret.UpdateBuffer(p18: any, p19: number) -- Line: 225
                    if not (p18.CLIENT_CLOCK and next(p18.CLIENT_CLOCK)) then
                        error("Config not initialized yet, cannot update buffer for entity type: " .. p18.NAME);
                    end;

                    p18.BUFFER = p19;

                    if p18.CLIENT_CLOCK.NORMAL then
                        p18.CLIENT_CLOCK.NORMAL:UpdateBuffer(p19);
                    end;

                    if p18.CLIENT_CLOCK.HALF then
                        p18.CLIENT_CLOCK.HALF:UpdateBuffer(p19);
                    end;

                    local Holder = require(script.Parent.Holder);
                    local Entity = require(script.Parent.Entity);

                    for _, v2 in Holder.idMap do
                        if v2.entityConfig == p18 then
                            Entity._UpdateClockBuffer(v2);
                        end;
                    end;
                end;
            end;

            u4[i] = table_clone_ret;
        end;

        for _, v in u8 do
            v();
        end;
    end,

    _WaitForLock = function(p20: function) -- Line: 190, Name: WaitForLock
        -- upvalues: u2 (ref), u8 (copy)
        if u2 then
            p20();

            return;
        end;

        table.insert(u8, p20);
    end,

    _GetBroadPhase = function(p21: string) -- Line: 181, Name: GetBroadPhase
        -- upvalues: u6 (copy)
        return u6[p21];
    end,

    _Base_Config = u3,

    SetModelPrimaryForChrono = function(p22: userdata, p23: string) -- Line: 277, Name: SetModelPrimaryForChrono
        p22:SetAttribute("__CHRONO_PRIMARY", p23);
    end,

    SetWarningSeverity = function(p24: string) -- Line: 198, Name: SetWarningSeverity
        -- upvalues: u3 (copy)
        if p24 ~= "NONE" and (p24 ~= "LOW" and (p24 ~= "MEDIUM" and p24 ~= "HIGH")) then
            error("Invalid warning level: " .. tostring(p24));
        end;

        u3.WARNING_SEVERITY = p24;
    end
};