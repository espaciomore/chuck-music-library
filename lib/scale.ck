// @author espaciomore
// @date Sat 2 Nov 2013
// @chuckversion 1.3.2.0
// @version 1.0.0.0

class Scale
{
    static Shred @track;
    static float cfreq;
    static float tratio;
    static <SinOsc> @osc;
    
    [1,2,3,4,5,6,7,8,8,7,6,5,4,3,2,1] @=> static int scale[];
    261.63 => cfreq;  
    500 => tratio;
    SinOsc s @=> osc;
    
    fun static void start(SinOsc osc, float tfreq, int sc[])
    {
        1.0 => float volume => osc.gain;  
        osc => dac;
        while(true)
        {
            for( 0 => int i; i < sc.size() ; i++ )
            { 
                tfreq + (sc[i]*6.875) => float freq;
                
                <<< "playing:", freq >>>; 
                
                freq => osc.freq;
                
                (freq/tratio)::second => now;
            }
        }
        osc =< dac;
    }
    fun static float play()
    {
        spork ~ start(osc, cfreq, scale) @=> track;
        0 => float duration;
        for( 0 => int i; i < scale.size() ; i++ )
        { 
            cfreq + (scale[i]*6.875) => float freq;
            
            freq +=> duration;
        }
        
        return (duration / tratio);
    }
}

// Scale x;
// 440 => x.cfreq;
// x.play() => float s;
// (s)::second => now;
// <<< "EOF" >>>;
