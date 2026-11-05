  

 

return {
    ["Wonder Of U"] = {
        State = "Passives",
        Description = "Wonder of U is a separate entity that follows the player, and wanders around them in direct combat.",
        Equipped = true,
        MoveCapCount = false
    },
    ["Calamity Cards"] = {
        State = "Passives",
        Description = "The user holds a deck of three cards, which you can access by drawing it. Each card contains a specific effect. When a card is used, it is consumed. Cards are regained over time.",
        Equipped = true,
        MoveCapCount = false
    },
    ["Post Mortem Persistence"] = {
        State = "Passives",
        Description = "Upon dying, your stand will still remain & end up forming its own entity as it would during pilot. This entity is controllable, but you\'d have less overall health. However, you keep the same attributes as you would while you\'re in pilot.",
        Equipped = true,
        MoveCapCount = false
    },
    ["Rush Attack"] = {
        DefaultKeybind = "MouseButton1",
        Equipped = true,
        MoveCapCount = false
    },
    Block = {
        DefaultKeybind = "F",
        Equipped = true,
        MoveCapCount = false
    },
    Quickstep = {
        DefaultKeybind = "C",
        Equipped = true,
        MoveCapCount = false
    },
    Pose = {
        DefaultKeybind = "P",
        Equipped = true,
        MoveCapCount = false
    },
    ["Ghastly Grab"] = {
        DefaultKeybind = "H",
        Description = "Wonder Of U goes after a target & grabs them before disappearing with them grabbed by his cane. Shortly after, Wonder Of U walks back to the you as you stomp the target in their head.",
        LevelRequirement = 45,
        State = "Base"
    },
    ["Cane Barrage"] = {
        DefaultKeybind = "E",
        Equipped = true,
        Description = "Wonder Of U performs a barrage using it\'s cane that ends with a heavy attack using it\'s cane."
    },
    ["Strong Kick"] = {
        DefaultKeybind = "R",
        Description = "Wonder Of U performs a simple kick.",
        Equipped = true
    },
    ["Obladi Oblada"] = {
        DefaultKeybind = "T",
        LevelRequirement = 15,
        Description = "Wonder of U deploys a rock insect at its location, which burrows into the ground and makes it way towards a target. If it makes contact, it will attach to its target and rapidly multiply, overtaking their entire body and dealing damage and slowdown."
    },
    ["Dododo De Dadada"] = {
        DefaultKeybind = "Y",
        LevelRequirement = 30,
        Description = "Wonder Of U sends a rock insect outwards from their position, which will stand stationary on the ground while throwing rock planks at nearby targets."
    },
    Apparition = {
        DefaultKeybind = "G",
        LevelRequirement = 60,
        Description = "Register your current position & health into one single place. Once attacked, you will teleport back right where you were & have the same HP as you did before."
    },
    ["Impact Calamity"] = {
        DefaultKeybind = "H",
        LevelRequirement = 105,
        Description = "Wonder Of U slams down the ground. The first target hit by this slam will fall prey to the current equipped calamity.",
        State = "Pilot"
    },
    Blight = {
        DefaultKeybind = "X",
        MoveCapCount = false,
        Equipped = true,
        Description = "Wonder of U possesses a target in front of it, attacking them multiple times before reappearing & throwing them away using a cane."
    },
    Disguise = {
        DefaultKeybind = "J",
        LevelRequirement = 90,
        State = "Pilot",
        Description = "Wonder Of U disguises itself as a player [if mouse-aimed towards one] or Dr. Akefu."
    },
    ["Draw Deck"] = {
        DefaultKeybind = "B",
        Equipped = true,
        Description = "Draw a deck of calamity cards and pick one which will be used in the next couple of seconds."
    },
    ["The Wonder Of U"] = {
        Description = "Exit the place & then let Wonder Of U act as it\'s own entity & attack people for you. Wonder Of U cannot be grabbed or stunned while in this state. Recast this key to return to your original form.",
        DefaultKeybind = "Q",
        Equipped = true
    }
};