.class final Lkotlin/coroutines/experimental/migration/ContextMigration;
.super Lkotlin/coroutines/AbstractCoroutineContextElement;
.source "CoroutinesMigration.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lkotlin/coroutines/experimental/migration/ContextMigration$Key;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    bv = {
        0x1,
        0x0,
        0x3
    }
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0005\u0008\u0002\u0018\u0000 \u00072\u00020\u0001:\u0001\u0007B\r\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0008"
    }
    d2 = {
        "Lkotlin/coroutines/experimental/migration/ContextMigration;",
        "Lkotlin/coroutines/AbstractCoroutineContextElement;",
        "context",
        "Lkotlin/coroutines/experimental/CoroutineContext;",
        "(Lkotlin/coroutines/experimental/CoroutineContext;)V",
        "getContext",
        "()Lkotlin/coroutines/experimental/CoroutineContext;",
        "Key",
        "kotlin-stdlib-coroutines"
    }
    k = 0x1
    mv = {
        0x1,
        0x1,
        0xf
    }
.end annotation


# static fields
.field public static final Key:Lkotlin/coroutines/experimental/migration/ContextMigration$Key;


# instance fields
.field private final context:Lkotlin/coroutines/experimental/CoroutineContext;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lkotlin/coroutines/experimental/migration/ContextMigration$Key;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lkotlin/coroutines/experimental/migration/ContextMigration$Key;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lkotlin/coroutines/experimental/migration/ContextMigration;->Key:Lkotlin/coroutines/experimental/migration/ContextMigration$Key;

    return-void
.end method

.method public constructor <init>(Lkotlin/coroutines/experimental/CoroutineContext;)V
    .locals 1

    const-string v0, "context"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkParameterIsNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    .line 93
    sget-object v0, Lkotlin/coroutines/experimental/migration/ContextMigration;->Key:Lkotlin/coroutines/experimental/migration/ContextMigration$Key;

    check-cast v0, Lkotlin/coroutines/CoroutineContext$Key;

    invoke-direct {p0, v0}, Lkotlin/coroutines/AbstractCoroutineContextElement;-><init>(Lkotlin/coroutines/CoroutineContext$Key;)V

    iput-object p1, p0, Lkotlin/coroutines/experimental/migration/ContextMigration;->context:Lkotlin/coroutines/experimental/CoroutineContext;

    return-void
.end method


# virtual methods
.method public final getContext()Lkotlin/coroutines/experimental/CoroutineContext;
    .locals 1

    .line 93
    iget-object v0, p0, Lkotlin/coroutines/experimental/migration/ContextMigration;->context:Lkotlin/coroutines/experimental/CoroutineContext;

    return-object v0
.end method
