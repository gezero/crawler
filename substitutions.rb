# https://xkcd.com/1288/
# https://xkcd.com/1625/
# https://xkcd.com/1679/


@substitutions = {
"Witnesses"=>"These dudes I know",
"Allegedly"=>"Kinda probably",
"New study"=>"Tumblr post",
"Rebuild"=>"Avenge",
"Space"=>"Spaaace",
"Google Glass"=>"Virtual Boy",
"Smartphone"=>"Pokédex",
"Electric"=>"Atomic",
"Senator"=>"Elf-lord",
"Car"=>"Cat",
"Election"=>"Eating contest",
"Congressional leaders"=>"River spirits",
"Homeland security"=>"Homestar Runner",
"Could not be reached for comment"=>"Is guilty and everyone knows it ",
"Debate"=>"Dance-off",
"Self driving"=>"Uncontrollably swerving",
"Poll"=>"Psychic reading",
"Candidate"=>"Airbender",
"Drone"=>"Dog",
"Vows to"=>"Probably won't",
"At large"=>"Very large",
"Successfully"=>"Suddenly",
"Expands"=>"Physically expands",
"First/second/third-degree"=>"Friggin' awful",
"An unknown number"=>"Like hundreds",
"Front runner"=>"Blade runner",
"Global"=>"Spherical",
"Years"=>"Minutes",
"Minutes"=>"Years",
"No indication"=>"Lots of signs",
"Urged restraint by"=>"Drunkenly egged on",
"Horsepower"=>"Tons of horsemeat ",
"Gaffe"=>"Magic spell",
"Ancient"=>"Haunted",
"Star-Studded"=>"Blood-soaked",
"Remains to be seen"=>"Will never be known",
"Silver bullet"=>"Way to kill werewolves",
"Subway system"=>"Tunnels I found",
"Surprising"=>"Surprising (but not to me)",
"War of words"=>"Interplanetary war",
"Tension"=>"Sexual tension",
"Cautiously optimistic"=>"Delusional",
"Doctor Who"=>"The Big Bang Theory",
"Win votes"=>"Find Pokémon",
"Behind the headlines"=>"Beyond the grave",
"Email"=>"Poem",
"Facebook Post"=>"Poem",
"Tweet"=>"Poem",
"Facebook CEO"=>"This guy",
"Latest"=>"Final",
"Disrupt"=>"Destroy",
"Meeting"=>"Ménage à trois",
"Scientists"=>"Channing Tatum and his friends",
"You won't believe"=>"I'm really sad about "
}

def fix s
    return nil,0 unless s
    count = 0
    @substitutions.each do |k,v|
        count += 1 if s.gsub!(/#{k}/i,v)
    end
    return s,count
end
