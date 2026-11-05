  

 

return {
    Statements = {
        [0] = {
            Statement = { "Nice talking to you.", "Bye.", "See ya." }
        },
        [0.5] = {
            Statement = { "Of course.", "My pleasure.", "Anytime, Master.", "I\'d do anything for you, Master.", "What\'s mine is yours." }
        },
        [1] = {
            Statement = { "Yes, Master?", "Hello, Master.", "How can I help?", "What\'s up?", {
                    Text = "Hey...",
                    Timing = {
                        [4] = 0.3,
                        [5] = 0.3,
                        [6] = 0.3
                    }
                } }
        },
        [2] = {
            Return = 0,
            Statement = { "Sure.", "I\'m on it.", {
                    Text = "Of course, Master.",
                    Timing = {
                        [10] = 0.3
                    }
                }, {
                    Text = "YESS FINALLY! I thought you\'d never- I mean.. Of course, Master...",
                    Timing = {
                        [36] = 1,
                        [44] = 0.3,
                        [45] = 0.3
                    }
                }, "Let\'s go!", "Where to?", "Sure thing.", "I\'d love to." }
        },
        [3] = {
            Return = 1,
            Include = 7,
            Statement = {
                "Be careful when out and about, I\'ve heard cultists have been spotted around this town.",
                "Watch out for people in green and black armor.",
                "I\'m well over 13.7 billion years old.",
                "My power is the ability to create and form many different things, not just planets. My gates have the ability to visit and see some of my own creations.",
                "One of my few rivals in speed is the Nuclear Star.",
                "My claws can easily tear kevlar, titanium, diamond, tungsten, etc... You just give me the command okay?",
                "You may be my Master, however I am not your \"Stand\"... I am something else.",
                "The rapture is coming sooner than you may think.",
                "I have had, and will have many more masters.",
                "Asteroids, energy, matter, it all bends before my might.",
                "No one else can understand my words but you, Master.",
                "In my lifetime, no one has gotten close enough to damage my hat.",
                "I gave you the ability to use that sword. To be honest, your capability with it is quite lackluster.",
                "My sword is forged from the hearts of stars and black holes."
            }
        }
    },
    ResponseOptions = {
        [1] = {
            Responses = { {
                    Response = "I need a Gate.",
                    Next = 2
                }, {
                    Responses = { {
                            { "Could you enlight me?", "Tell me something.", "Tell me a fact." },
                            Next = 3
                        }, {
                            "Talk to me about our universe.",
                            "Tell me about your past.",
                            Next = 4
                        } }
                }, {
                    Response = "What are you?",
                    Next = 5
                }, {
                    Response = "How are you?",
                    Next = 6
                } }
        },
        [2] = {
            Responses = {}
        },
        [7] = {
            Responses = { {
                    Response = "Thanks.",
                    Next = 0.5
                } }
        },
        [8] = {
            Responses = { {
                    Response = "Bye, Planet // Shaper.",
                    Next = 0
                } }
        }
    }
};