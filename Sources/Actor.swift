//
// Copyright (c) 2016 Huawei PT-Lab Open Source project authors.
// Licensed under Apache License v2.0
//
// Actor.swift
// The Actor protocols
//

public protocol UnspecifiedActor {
    /// The context of this actor
    unowned var context:ActorCell { get }

    mutating func supervisorStrategy(error: Error) -> Void
    
    mutating func preStart()
    mutating func willStop()
    mutating func postStop()
    mutating func childTerminated(_ child: ActorRef)
}

extension UnspecifiedActor {
    public var this: ActorRef { return context.this }
}

public protocol Actor: UnspecifiedActor {
    /// The context of this actor
    unowned var actorContext:KnownActorCell<Self> { get }

    associatedtype ActorMessage: Message
    mutating func receive(_ msg: ActorMessage)
}

extension Actor {
    public var context: ActorCell {
        get { return actorContext }
    }
    public var ref: KnownActorRef<Self> { return actorContext.ref }
}
