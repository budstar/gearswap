-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('organizer-lib.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Myochin Kabuto",hands="Sakonji Kote +1","Smertrios's Mantle"}
    sets.precast.JA['Warding Circle'] = {head="Myochin Kabuto"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
	
	 -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		head="Ken. Jinpachi",
		body={ name="Nuevo Coselete", augments={'Enmity+5','"Fast Cast"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Limbo Trousers",
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = { 
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		mmo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, { 
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {
		mmo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})
    
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Snow Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",})
   
    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, { 
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Flamma Korazin +2",
		hands="Flam. Manopolas +2",
		legs="Flamma Dirs +1",
		feet="Flam. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, { 
		ammo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})
    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS.Acc, {
		mmo="Ginsen",
		head={ name="Valorous Mask", augments={'Attack+18','Weapon skill damage +2%','STR+10','Accuracy+15',}},
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+16 Attack+16','Weapon skill damage +5%','DEX+10','Attack+14',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})

	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, { 
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands="Flam. Manopolas +2",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Apate Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})
    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {
		mmo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Ryuo Domaru", augments={'HP+50','"Store TP"+5','"Dbl.Atk."+2',}},
		hands="Flam. Manopolas +2",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Pet: INT+6','STR+5','Weapon skill damage +5%','Accuracy+6 Attack+6',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +250',}},
		left_ring="Flamma Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	})

    -- Midcast Sets
    sets.midcast.FastRecast = {
		ammo="Hasty Pinion +1",
		head="Ken. Jinpachi",
		body={ name="Nuevo Coselete", augments={'Enmity+5','"Fast Cast"+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}},
		legs="Limbo Trousers",
		feet={ name="Amm Greaves", augments={'HP+50','VIT+10','Accuracy+15','Damage taken-2%',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Lebeche Ring",
		back="Solemnity Cape",
	}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Wiglen Gorget",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = { 
		ammo="Staunch Tathlum",
		head={ name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}},
		body="Hiza. Haramaki +2",
		hands="Rao Kote",
		legs={ name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}},
		feet="Danzo Sune-Ate",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
    
    sets.idle.Field = {
        ammo="Staunch Tathlum",
		head={ name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}},
		body="Hiza. Haramaki +2",
		hands="Rao Kote",
		legs={ name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}},
		feet="Danzo Sune-Ate",
		neck="Sanctity Necklace",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}

    sets.idle.Weak = {
		ammo="Staunch Tathlum",
		head="Twilight Helm",
		body="Twilight Mail",
		hands={ name="Sakonji Kote +1", augments={'Enhances "Blade Bash" effect',}},
		legs={ name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}},
		feet="Danzo Sune-Ate",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back="Solemnity Cape",
	}
    
    -- Defense sets
    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Yaoyotl Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Karieyh Brayettes +1",feet="Otronif Boots +1"}

    sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +2",
		legs={ name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}},
		feet={ name="Ryuo Sune-Ate", augments={'HP+50','"Store TP"+4','"Subtle Blow"+7',}},
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Acc = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.PDT = {
		ammo="Staunch Tathlum",
		head="Ken. Jinpachi",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Acc.PDT = {
		ammo="Staunch Tathlum",
		head="Ken. Jinpachi",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Acc.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    sets.engaged.Adoulin = { 
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +2",
		legs={ name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}},
		feet={ name="Ryuo Sune-Ate", augments={'HP+50','"Store TP"+4','"Subtle Blow"+7',}},
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Adoulin.Acc = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Flamma Ring",
		right_ring="Petrov Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Adoulin.PDT = {
		ammo="Staunch Tathlum",
		head="Ken. Jinpachi",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Adoulin.Acc.PDT = {
		ammo="Staunch Tathlum",
		head="Ken. Jinpachi",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Ken. Hakama",
		feet="Flam. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Vocane Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
    sets.engaged.Adoulin.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Ik Cape",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}
    sets.engaged.Adoulin.Acc.Reraise = {ammo="Thew Bomblet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Goading Belt",legs="Unkai Haidate +2",feet="Otronif Boots +1"}


    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 4)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 4)
    else
        set_macro_page(1, 4)
    end
end
