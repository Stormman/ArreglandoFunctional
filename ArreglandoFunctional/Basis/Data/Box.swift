//
//  Box.swift
//  Basis
//
//  Created by Robert Widmann on 9/9/14.
//  Copyright (c) 2014 TypeLift. All rights reserved.
//  Released under the MIT license.
//

/// The infamous Box Hack.
///
/// A box is also equivalent to the identity functor, which is also the most trivial instance of
/// Comonad.

protocol Comonad__ {}
protocol ComonadApply__{}

public final class Box<AA> : K1<AA > {
	public let unBox : () -> AA
	
	public init(_ x : AA ) {
		unBox = { x }
	}
}

/// MARK: Equatable

public func ==<T : Equatable>(lhs: Box<T>, rhs: Box<T>) -> Bool {
	return lhs.unBox() == rhs.unBox()
}

public func !=<T : Equatable>(lhs: Box<T>, rhs: Box<T>) -> Bool {
	return !(lhs == rhs)
}

/// MARK: Functor

extension Box : Functor__ {
   
    

    
  
    public typealias B = Any

    
    public typealias A = AA
   
	
	typealias FB = Box<B>
	
     class func fmap<B>(_ f :@escaping  (AA ) -> B) -> (Box<AA>) -> Box<B>   {
		return { b in Box<B>(f(b.unBox())) }
	}
}

public func <%> <A, B>(_ f : @escaping (A) -> B, _ b : Box<A>) -> Box<B> {
    
    //let poii = Box<A>.fmap(f)
    
    
    return Box.fmap(f)(b)
}
public func <% <A, B>(a : A, b : Box<B>) -> Box<A> {
    return (curry(<%>) • const)(a)(b)
}

extension Box : Pointed {
    public class func pure(_ x : A) -> Box<A> {
		return Box(x)
	}
}

extension Box : Copointed {
	public func extract() -> A {
		return self.unBox()
	}
}

extension Box : Comonad__ {
	typealias FFA = Box<Box<A>>
	
	public class func duplicate(b : Box<A>) -> Box<Box<A>> {
		return Box<Box<A>>(b)
	}
	
    
	
    public class func extend<B>(f : @escaping  (Box<A>)-> B) -> (Box<A>) -> Box<B> {
		return { b in 
            return Box<Box<A>>.fmap(f)(Box<A>.duplicate(b: b))
		}
	}
}

extension Box : ComonadApply__ {
    typealias FAB = Box<(A) -> B>
}

public func >*< <A, B>(fab : Box<(A) -> B> , b : Box<A>) -> Box<B> {
	return Box(fab.unBox()(b.unBox()))
}
/*
public func *< <A, B>(a : Box<A>, b : Box<B>) -> Box<B> {
	return const(id) <%> a >*< b
}

public func >* <A, B>(a : Box<A>, b : Box<B>) -> Box<A> {
	return const <%> a >*< b
}
*/
