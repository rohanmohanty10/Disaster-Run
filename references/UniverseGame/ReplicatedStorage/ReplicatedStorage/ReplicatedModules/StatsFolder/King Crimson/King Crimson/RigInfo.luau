  

 

return {
    Transformer = function(p1) -- Line: 2, Name: Transformer
        return p1.RigInfo;
    end,

    PostRig = function(p2) -- Line: 6, Name: PostRig
        return p2.RigInfo;
    end,

    Rigs = {
        Stand = {
            From = "Stand",
            Children = {
                StandModel = {
                    From = "StandModel",
                    RigModel = "~/StandModel"
                },
                StandEffects = {
                    From = "StandModel",
                    RigModel = "~/StandEffects"
                }
            }
        }
    }
};