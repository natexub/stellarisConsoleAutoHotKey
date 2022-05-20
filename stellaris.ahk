#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^j:: ; ctrl+j run

SendCommand(command){
    SendRaw %command%
    Send {Enter}
    Sleep 100
    return
}

Console(commands){
    For index, value in commands {
        SendCommand(value)
    }
}

; 将数组合并到一个新数组
Concat(arrays*){
    newArray := []
    For arrayIndex, array in arrays {
        For index, item in array {
            newArray.Push(item)
        }
    }
    return newArray
}

AddCommand(commands, commandType, itemList, _id){
    For index, item in itemList {
        if (_id == -1){
                command := commandType " " item
        } else {
            command := commandType " " _id " " item
        }
        commands.Push(command)
    }
    return commands
}

AddEffectToPlant(){
    effects_1:=["effect add_modifier={modifier=extensive_moon_system days=-1}","effect add_modifier={modifier=mineral_rich days=-1}","effect add_modifier={modifier=ultra_rich days=-1}","effect add_modifier={modifier=lush_planet days=-1}", "effect add_modifier={modifier=natural_beauty days=-1}", "effect add_modifier={modifier=asteroid_belt days=-1}", "effect add_modifier={modifier=paradise_planet days=-1}", "effect add_modifier={modifier=strong_magnetic_field days=-1}", "effect add_modifier={modifier=carbon_world days=-1}"]
    effects_2:=["effect add_deposit = d_organic_landfill","effect add_deposit = d_metal_boneyard", "effect add_deposit = d_ancient_mining_site","effect add_deposit = d_harvester_fields","effect add_deposit = d_odd_factory", "effect add_deposit = d_betharian_deposit","effect add_deposit = d_fuming_bog", "effect add_deposit = d_crystal_forest", "effect add_deposit = d_dust_desert", "effect add_deposit = d_alien_pets_deposit", "effect add_deposit = d_wetware_computer","effect add_deposit = d_valley_of_zanaam", "effect add_deposit = d_dragon_monument"]
    return Concat(effects_1, effects_2, effects_2, effects_2)
}
AddTraitsToSpecie(commands, specieId){
    specieTraits := ["trait_adaptive","trait_agrarian","trait_charismatic", "trait_communal", "trait_conformists", "trait_conservational", "trait_docile", "trait_enduring", "trait_industrious", "trait_ingenious", "trait_intelligent", "trait_natural_engineers", "trait_natural_physicists", "trait_natural_sociologists", "trait_nomadic", "trait_quick_learners", "trait_rapid_breeders", "trait_resilient", "trait_strong", "trait_talented", "trait_thrifty", "trait_traditional", "trait_very_strong", "trait_venerable", "trait_extremely_adaptive", "trait_fertile", "trait_robust", "trait_erudite"]
    return AddCommand(commands, "add_trait_species", specieTraits, specieId)
}
AddTraitsToLeaders(commands, leadersId){
    leaderTraits := ["40","42","44", "46", "47","60", "61", "63", "64", "131", "132", "134", "136", "137", "138","279","280", "284", "286", "287","300", "301", "302"]
    Loop {
        num := 67+A_Index
        If(num == 101){
            break
        } else {
            leaderTraits.Push(num)
        }
    }
    For index, leaderId in leadersId {
        AddCommand(commands, "add_trait_leader", leaderTraits, leaderId)
    }
    return
}
AddAscensionPerk(commands){
    ; 没有 ap_become_the_crisis ap_transcendence ap_synthetic_evolution ap_synthetic_evolution ap_the_flesh_is_weak ap_mind_over_matter ap_hydrocentric Hive Worlds Machine Worlds
    perks := ["ap_consecrated_worlds", "ap_eternal_vigilance", "ap_executive_vigor","ap_galactic_wonders_utopia_and_megacorp","ap_imperial_prerogative", "ap_interstellar_dominion", "ap_mastery_of_nature", "ap_lord_of_war", "ap_nihilistic_acquisition", "ap_one_vision","ap_shared_destiny","ap_technological_ascendancy","ap_transcendent_learning", "ap_universal_transactions", "ap_voidborn", "ap_xeno_compatibility", "ap_enigmatic_engineering", "ap_grasp_the_void", "ap_world_shaper", "ap_arcology_project", "ap_galactic_force_projection", "ap_master_builders", "ap_colossus", "ap_defender_of_the_galaxy", "ap_galactic_contender","ap_engineered_evolution", "ap_evolutionary_mastery"]
    return AddCommand(commands, "activate_ascension_perk", perks, -1)
}


; debugtooltip

Commands := ["max_resources", "activate_all_traditions","add_relic all","research_all_technologies 0 10","free_policies","free_government","unlock_edicts"]

AddAscensionPerk(Commands)

leaders:= ["0","1","2","3","4"]
AddTraitsToLeaders(Commands,  leaders)

specieId := "1"
AddTraitsToSpecie(Commands, specieId)


; Commands := AddEffectToPlant() ; run when planet panel opened

Console(Commands)
return