  

 

return {
    Active = {
        Quote = 10,
        Main = 20
    },
    Stun = {
        Block = 10,
        Light = 20,
        Medium = 30,
        Heavy = 40,
        True = 1000
    },
    Intangible = {
        SoftRagdoll = 5,
        Ragdoll = 10,
        Dodge = 15,
        Quickstep = 20,
        Dash = 20,
        PerfectBlock = 30,
        Clash = 45,
        Grab = 47,
        Move = 50,
        Counter = 60,
        Ultimate = 70,
        True = 1000
    },
    HighlightPriority = {
        MeterUp = 20,
        PerfectBlock = 25,
        PerfectBlockOutline = 30
    },
    Hitboxes = {
        Stand_Rush_Attack = {
            Size = Vector3.new(6, 5.5, 8),
            Offset = CFrame.new(0, 0, -4)
        },
        Stand_Barrage = {
            Size = Vector3.new(6, 5.5, 8.5),
            Offset = CFrame.new(0, 0, -5.5)
        }
    },
    AnimationStatePriority = {
        Default = 0,
        Ability = 10
    },
    CompensationType = {
        Server = 0,
        Client = 1,
        Rollback = 2,
        Regulate = 3
    },
    Step = {
        Dash = -10,
        Main = 0
    },
    Grab = {
        Main = 0,
        Cutscene = 10
    },
    PerfectBlock = {
        Light = 0,
        Medium = 10,
        Heavy = 20
    },
    AttackPriority = {
        Light = 0,
        Medium = 50,
        Heavy = 100,
        Super = 200,
        Ultimate = 300
    },
    IndicatorPriority = {
        First = 0,
        Priority = 100,
        Input = 200,
        Type = 300,
        Behavior = 400,
        Effect = 500,
        Last = 10000
    },

    Get = function(p1, p2) -- Line: 94, Name: Get
        if typeof(p1) == "string" and p2 then
            return p2[p1];
        end;

        return p1;
    end
};