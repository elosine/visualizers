(
s.waitForBoot{
	fork{
		~b1 = Buffer.read(s, "/Volumes/JY_Archive 2/___Archive/Tracks_masters/STBB 453 I been down so long .aif");
		~proc = NetAddr("127.0.0.1", 12321);
		~bus1 = Bus.control(s);

		SynthDef(\sampy, {
			arg buf=0, kbus=0;
			var sig, rms;
			sig = PlayBuf.ar(1, buf, loop:1, );
			rms = Amplitude.kr(sig).ampdb.linlin(-30.0, 0.0, 0.0, 1.0);
			Out.kr(kbus, rms);
			Out.ar(0, sig);
		}).add;

		OSCdef(\getamp, {
			~proc.sendMsg("/amp1", ~bus1.getSynchronous.asFloat);
		}, "/getamp");

		0.1.wait;
		~s1 = Synth(\sampy, [\buf, ~b1, \kbus, ~bus1]);

	}
}
)




