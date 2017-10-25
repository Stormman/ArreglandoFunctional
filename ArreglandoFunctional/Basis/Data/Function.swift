//
//  Function.swift
//  Basis
//
//  Created by Robert Widmann on 9/7/14.
//  Copyright (c) 2014 TypeLift. All rights reserved.
//  Released under the MIT license.
//

/// The type of a function from T -> U.

protocol Category__{}
protocol Arrow__{}
protocol ArrowChoice__{}
protocol ArrowApply__ {}
protocol ArrowLoop__{}

public struct Function<T, U> {
    public typealias A = T
    public typealias B = U
    public typealias C = Any

    let ap : (T) -> U

    public init(_ apply :@escaping (T)  -> U) {
		self.ap = apply
	}
	
	public func apply(_ x : T) -> U {
		return self.ap(x)
	}
}

extension Function : Category__ {
	typealias CAA = Function<A, A>
	typealias CBC = Function<B, C>
	typealias CAC = Function<A, C>
	
	public static func id() -> Function<T, T> {
		return Function<T, T>({ $0 })
	}
}

public func • <A, B, C>(c : Function<B, C>, c2 : Function<A, B>) -> Function<A, C> {
	return ^{ c.apply(c2.apply($0)) }
}

public func <<< <A, B, C>(c1 : Function<B, C>, c2 : Function<A, B>) -> Function<A, C> {
	return c1 • c2
}

public func >>> <A, B, C>(c1 : Function<A, B>, c2 : Function<B, C>) -> Function<A, C> {
	return c2 • c1
}

extension Function : Arrow__ {
    public typealias D = T
    public typealias E = Any
	
	typealias FIRST = Function<(A, D), (B, D)>
	typealias SECOND = Function<(D, A), (D, B)>
	
	typealias ADE = Function<D, E>
	typealias SPLIT = Function<(A, D), (B, E)>
	
	typealias ABD = Function<A, D>
	typealias FANOUT = Function<A, (B, D)>
	
    public static func arr(_ f : @escaping (T)  -> U) -> Function<A, B> {
		return Function<A, B>(f)
	}
	
	public func first() -> Function<(T, T), (U, T)> {
		return self *** Function.id()
	}
	
	public func second() -> Function<(T, T), (T, U)> {
		return Function.id() *** self
	}
}

public func *** <B, C, D, E>(f : Function<B, C>, g : Function<D, E>) -> Function<(B, D), (C, E)> {
	return ^{ (x, y) in  (f.apply(x), g.apply(y)) }
}

public func &&& <A, B, C>(f : Function<A, B>, g : Function<A, C>) -> Function<A, (B, C)> {
	return ^{ b in (b, b) } >>> f *** g
}

extension Function : ArrowChoice__ {
	typealias LEFT = Function<Either<A, D>, Either<B, D>>
	typealias RIGHT = Function<Either<D, A>, Either<D, B>>
	
	typealias SPLAT = Function<Either<A, D>, Either<B, E>>
	
	typealias ACD = Function<B, D>
	typealias FANIN = Function<Either<A, B>, D>
	
	public static func left(f : Function<A, B>) -> Function<Either<A, D>, Either<B, D>> {
		return f +++ Function.id()
	}
	
	public static func right(f : Function<A, B>) -> Function<Either<D, A>, Either<D, B>> {
		return Function.id() +++ f
	}
}
/*
public func +++ <B, C, D, E>(f : Function<B, C>, g : Function<D, E>) -> Function<Either<B, D>, Either<C, E>> {
	return ^Either.left • f ||| ^Either.right • g
}
*/
public func ||| <B, C, D>(f : Function<B, D>, g : Function<C, D>) -> Function<Either<B, C>, D> {
	return ^either(f^)(g^)
}

extension Function : ArrowApply__ {
	typealias APP = Function<(Function<A, B>, A), B>
	
	public static func app() -> Function<(Function<T, U>, A), B> {
		return Function<(Function<T, U>, A), B>({ (f, x) in f.apply(x) })
	}
	
	public static func leftApp<C>(f : Function<A, B>) -> Function<Either<A, C>, Either<B, C>> {
        let l : Function<A, (Function<Void, Either<B, C>>, Void)> = ^{ ( a : A) -> (Function<Void, Either<B, C>>, Void) in (Function<Void, A>.arr({ _ in a }) >>> f >>> Function<B, Either<B, C>>.arr(Either.left), Void()) }
        let r : Function<C, (Function<Void, Either<B, C>>, Void)> = ^{ ( c : C) -> (Function<Void, Either<B, C>>, Void) in (Function<Void, C>.arr({ _ in c }) >>> Function<C, Either<B, C>>.arr(Either.right), Void()) }

		return (l ||| r) >>> Function<Void, Either<B, C>>.app()
	}
}

extension Function : ArrowLoop__ {
	typealias LOOP = Function<(A, D), (B, D)>
	
	public static func loop<B, C>(_ f : Function<(B, D), (C, D)>) -> Function<B, C> {
		return ^({ k in Function.loop(f).apply(k) })
	}
}
