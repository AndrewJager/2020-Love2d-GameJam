uare = require "Libraries/uare"

ui = {}
local function load(game, space)
    btnProcessStyle = uare.newStyle({
        width = 200,
        height = 60,
        --color
        color = {0.00,0.82,0.08},
        hoverColor = {0.00,0.62,0.08},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.01,0.17,0.02},
        hoverColor = {0.01,0.17,0.02},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.btnFont,
        align = "center",
        offset = {
            x = 0,
            y = -25
        }
        },
    })
    btnExitStyle = uare.newStyle({
        width = 75,
        height = 20,
        --color
        color = {0.50,0.00,0.00},
        hoverColor = {0.40,0.00,0.00},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.0,0.0,0.0},
        hoverColor = {0.0,0.0,0.0},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.exitBtnFont,
        align = "center",
        offset = {
            x = 0,
            y = -8,
        }
        },
    })
    btnPlayStyle = uare.newStyle({
        width = 50,
        height = 50,
        --color
        color = {0.30,0.30,0.30},
        hoverColor = {0.10,0.10,0.10},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.0,0.0,0.0},
        hoverColor = {0.0,0.0,0.0},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.exitBtnFont,
        align = "center",
        offset = {
            x = 0,
            y = -8,
        }
        },
    })
    btnSendStyle = uare.newStyle({
        width = 250,
        height = 50,
        --color
        color = {0.00,0.82,0.08},
        hoverColor = {0.00,0.62,0.08},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.0,0.0,0.0},
        hoverColor = {0.0,0.0,0.0},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.exitBtnFont,
        align = "center",
        offset = {
            x = 0,
            y = -8,
        }
        },
    })
    btnCommentStyle = uare.newStyle({
        width = 400,
        height = 30,
        --color
        color = {0.30,0.30,0.30},
        hoverColor = {0.10,0.10,0.10},
        holdColor = {0.066, 0.047, 0.152},
        --border
        border = {
        color = {0.0,0.0,0.0},
        hoverColor = {0.0,0.0,0.0},
        holdColor = {0.031, 0.349, 0.090},
        size = 5
        },
        --text
        text = {
        color = {0.9, 0.9, 0.9},
        hoverColor = {0.9, 0.9, 0.9},
        holdColor = {0.9, 0, 0},
        font = game.commentFont,
        align = "center",
        offset = {
            x = 0,
            y = -8,
        }
        },
    })

    freq1 = uare.new({
        text = {
        display = "2110 - 7145"
        },
        x = 425,
        y = 545,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "A"
        end
        
    }):style(btnProcessStyle)
    freq2 = uare.new({
        text = {
        display = "7190 - 8450"
        },
        x = 425,
        y = 615,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "B"
        end
        
    }):style(btnProcessStyle)
    freq3 = uare.new({
        text = {
        display = "8451 - 31800"
        },
        x = 635,
        y = 545,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "C"
        end
        
    }):style(btnProcessStyle)
    freq4 = uare.new({
        text = {
        display = "31801 - 34700"
        },
        x = 635,
        y = 615,
        onClick = function() 
            space.mode = "process"
            space.selectedFreq = "D"
        end
        
    }):style(btnProcessStyle)
    exit = uare.new({
        text = {
        display = "Close"
        },
        x = 780,
        y = 510,
        onClick = function() 
            space.mode = "search"
            space.selectedFreq = nil
            space.selectedStar = nil
            space.playSignal = false
            space.playingSignal = false
        end
    }):style(btnExitStyle)
    play = uare.new({
        text = {
        display = "Play"
        },
        x = 400,
        y = 525,
        onClick = function() 
            space.playSignal = true
        end
    }):style(btnPlayStyle)
    stop = uare.new({
        text = {
        display = "Stop"
        },
        x = 400,
        y = 580,
        onClick = function() 
            space.playSignal = false
            space.playingSignal = false
            space.sigStep = 1
        end
    }):style(btnPlayStyle)
    send = uare.new({
        text = {
        display = "Send to Mission Control"
        },
        x = 480,
        y = 510,
        onClick = function() 
            space.showComments = true
        end
    }):style(btnSendStyle)
    comment1 = uare.new({
        text = {
        display = "Comment 1"
        },
        x = 460,
        y = 550,
        onClick = function() 
            local signal = space.stars.getSelectedSignal(space.selectedStar, space.selectedFreq)
            space.mode = "message"
            space.selectedComment = "A"
            space.message = space.story.parseSignal(signal, space)
            space.mood = space.mood + signal.commentWeights[1]
        end
    }):style(btnCommentStyle)
    comment2 = uare.new({
        text = {
        display = "Comment 2"
        },
        x = 460,
        y = 590,
        onClick = function() 
            local signal = space.stars.getSelectedSignal(space.selectedStar, space.selectedFreq)
            space.mode = "message"
            space.selectedComment = "B"
            space.message = space.story.parseSignal(signal, space)
            space.mood = space.mood + signal.commentWeights[2]
        end
    }):style(btnCommentStyle)
    comment3 = uare.new({
        text = {
        display = "Comment 3"
        },
        x = 460,
        y = 630,
        onClick = function() 
            local signal = space.stars.getSelectedSignal(space.selectedStar, space.selectedFreq)
            space.mode = "message"
            space.selectedComment = "C"
            space.message = space.story.parseSignal(signal, space)
            space.mood = space.mood + signal.commentWeights[3]
        end
    }):style(btnCommentStyle)
    response1 = uare.new({
        text = {
        display = "Understood"
        },
        x = 250,
        y = 640,
        onClick = function() 
            space.mode = "search"
        end
    }):style(btnCommentStyle)

end
ui.load = load 
return ui 