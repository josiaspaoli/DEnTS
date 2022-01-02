function[play] = calcula_acao_dealer_headsup(cartas, BigBlind, ValorCall, Stack, Pot)

    if Stack <= 10*BigBlind
        qtf = 1;
    elseif   10*BigBlind < Stack && Stack <= 20*BigBlind
        qtf = 2;
    else
        qtf = 3;
    end

    pp = ValorCall/Pot;
    odds = pfodds(cartas);
    pot = Pot/BigBlind;

    if (qtf==1)
        if(odds>=0.58)
            play = 51;
        end

        if(odds>=0.51 && odds<0.58)
            if (pot<=3)
                play = 11;
            end
            if (pot>3)
                play = 1;
            end
        end

        if(odds<0.51)
            play=1;
        end
    elseif (qtf==2)
        if(odds>=0.77)
            if(pot<=10)
                play = 51;
            end
            if(pot>10)
                play=51;
            end
        end

        if(odds>=0.61 && odds<0.77)
            if(pot<=3)
                play = 21;
            end
            if(pot>3)
                if(pp>=0.6)
                    play=1;
                end
                if(pp<0.6)
                    play=11;
                end
            end
        end

        if(odds>=0.55 && odds<0.61)
            if(pot<=3)
                play = 11;
            end
            if(pot>3)
                if(pp>0.5)
                    play=1;
                end
                if(pp<=0.5)
                    play=11;
                end
            end
        end

        if(odds>=0.51 && odds<0.55)
            if(pot<=3)
                play = 11;
            end
            if(pot>3)
                play = 1;
            end
        end

        if(odds<0.51)
            play=1;
        end


    elseif(qtf==3)
        if(odds>=0.77)
            if(pot<=10)
                play = 51;
            end
            if(pot>10)
                play=51;
            end
        end

        if(odds>=0.68 && odds<0.77)
            if(pot<=3)
                play = 21;
            end
            if(pot>3)
                if(pp>=0.6)
                    play=1;
                end
                if(pp<0.6)
                    play=11;
                end
            end
        end

        if(odds>=0.55 && odds<0.68)
            if(pot<=3)
                play = 11;
            end
            if(pot>3)
                if(pp>0.6)
                    play=1;
                end
                if(pp<=0.6)
                    play=11;
                end
            end
        end

        if(odds<0.55)
            if(pot<=3)
                play = 11;
            end
            if(pot>3)
                play = 1;
            end
        end
    end

end