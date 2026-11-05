  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);

return {
    Ability = function(p1) -- Line: 8, Name: Ability
        return p1;
    end,

    Move = function(p2) -- Line: 12, Name: Move
        return p2;
    end,

    Attack = function(p3) -- Line: 16, Name: Attack
        local v4 = p3 == nil and {} or p3;
        v4._IsAttack = true;

        return v4;
    end,

    Hitbox = function(p5) -- Line: 24, Name: Hitbox
        return p5;
    end,

    Sequence = function(p6) -- Line: 28, Name: Sequence
        return p6;
    end,

    Projectile = function(p7) -- Line: 33, Name: Projectile
        return p7;
    end
};