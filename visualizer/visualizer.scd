b = Buffer.read(s,"/home/ddmi/Downloads/314965__modularsamples__yamaha-cs-30l-toy-piano-c5-small-plick-72-127.aiff" );
c = Buffer.read(s, "/home/ddmi/Downloads/252855__johnlavine333__faux-bassline-2-take-2-raw.aiff");
~proc = NetAddr("127.0.0.1", 12321);

SynthDef(\sampy, {
	arg buf=0;
	var sig, ampd;
	//sig = SinOsc.ar();
	sig = PlayBuf.ar(1, buf, loop:1, );
	ampd = Amplitude.kr(sig);
	SendTrig.kr( Impulse.kr(60), value:ampd);
	Out.ar(0, sig);
}).add;

OSCdef(\amptrig, {
	|msg| msg.postln;
	~proc.sendMsg("/amp1", msg[3].asFloat);
}, '/tr', s.addr);

~s1 = Synth(\sampy, [\buf, c]);


Tartini.ar



