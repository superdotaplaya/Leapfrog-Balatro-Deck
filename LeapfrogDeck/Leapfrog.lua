--- STEAMODDED HEADER
--- MOD_NAME: Leapfrog Deck
--- MOD_ID: LeapfrogDeck
--- MOD_AUTHOR: [SuperDotaPlaya]
--- MOD_DESCRIPTION: Feeling froggy? Start with all even cards, 0 discards, and playing poker hands other than straights costs $2!
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE -------------------------

function check_even(card)
    if (card % 2 == 0) then
            return(true)
        else
            return(false)
        end
    end


SMODS.Atlas{
        key = "leapfrog",
        px = 71,
        py = 95,
        path = "frog.png"
}

SMODS.Back{
    name = "Leapfrog Deck",
    key = "leapfrog",
    atlas = "leapfrog",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "Leapfrog Deck",
        text ={
            "Start with all even cards",
            "Start with a copy of the {C:red,T:j_shortcut}Shortcut{} joker",
            "{C:red}Lose{} {C:attention}$2{} when you do not play a {C:attention}Straight{}"
        },
    },
    
    apply = function()
        print("TESTING")
        G.E_MANAGER:add_event(Event({
            func = function()
                for i = #G.playing_cards, 1, -1 do
                    if G.playing_cards[i]:get_id() >= 11 then
                        G.playing_cards[i]:start_dissolve(nil, true)
                    else
                        is_even = check_even(G.playing_cards[i]:get_id())
                        if is_even == false then
                            G.playing_cards[i]:start_dissolve(nil, true)
                        end
                    end
                    
                end
            
                add_joker("j_shortcut", nil, true, false)
                G.GAME.dollars = 0
                G.GAME.round_resets.discards = 0

                return true
            end,
            calculate = function(self, context)
            
        end
}))
end,
calculate = function(self, back, context)
    if context.before then
        if next(context.poker_hands["Straight"]) then
            print("straight played")
        else
            ease_dollars(-2)
        end
    end
end
}

