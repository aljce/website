import java.util.function.*;
public class IO<A> {
    private Function<RealWorld,Tuple<RealWorld,A>> transform;
    private class RealWorld {
        private int token;
        public RealWorld() {
            this.token = 0;
        }
    }
    private class Tuple<F,S> {
        public F fst;
        public S snd;
        public Tuple(F fst, S snd) {
            this.fst = fst;
            this.snd = snd;
        }
    }
    public IO(Function<RealWorld,Tuple<RealWorld,A>> transform) {
        this.transform = transform;
    }
    public Function<RealWorld,Tuple<RealWorld,A>> getTransform() {
        return this.transform;
    }
    public IO<A> pure(A a) {
        return new IO<A>(r -> new Tuple<RealWorld,A>(r,a));
    }
    public <B,C> IO<C> bind(IO<B> io, Function<B,IO<C>> f) {
        return new IO<C>(r -> {
             Tuple<RealWorld,B> result = io.transform.apply((RealWorld) r);
             IO<C> ioC = f.apply(result.snd);
             return ioC.transform.apply((RealWorld) result.fst);
        });
    }
}
