.class public final Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;
.super Ljava/lang/Object;
.source "Util.kt"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;->settings(ZLokhttp3/internal/http2/Settings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nUtil.kt\nKotlin\n*S Kotlin\n*F\n+ 1 Util.kt\nokhttp3/internal/Util$execute$1\n+ 2 Util.kt\nokhttp3/internal/Util\n+ 3 Http2Connection.kt\nokhttp3/internal/http2/Http2Connection$ReaderRunnable\n*L\n1#1,569:1\n377#2,9:570\n663#3,2:579\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    bv = {
        0x1,
        0x0,
        0x3
    }
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002\u00a8\u0006\u0003"
    }
    d2 = {
        "<anonymous>",
        "",
        "run",
        "okhttp3/internal/Util$execute$1"
    }
    k = 0x3
    mv = {
        0x1,
        0x1,
        0xf
    }
.end annotation


# instance fields
.field final synthetic $clearPrevious$inlined:Z

.field final synthetic $name:Ljava/lang/String;

.field final synthetic $settings$inlined:Lokhttp3/internal/http2/Settings;

.field final synthetic this$0:Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;ZLokhttp3/internal/http2/Settings;)V
    .locals 0

    iput-object p1, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$name:Ljava/lang/String;

    iput-object p2, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->this$0:Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;

    iput-boolean p3, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$clearPrevious$inlined:Z

    iput-object p4, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$settings$inlined:Lokhttp3/internal/http2/Settings;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 5

    .line 390
    iget-object v0, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$name:Ljava/lang/String;

    .line 570
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    const-string v2, "currentThread"

    .line 571
    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkExpressionValueIsNotNull(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object v2

    .line 572
    invoke-virtual {v1, v0}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    .line 579
    :try_start_0
    iget-object v0, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->this$0:Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;

    iget-boolean v3, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$clearPrevious$inlined:Z

    iget-object v4, p0, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable$settings$$inlined$tryExecute$1;->$settings$inlined:Lokhttp3/internal/http2/Settings;

    invoke-virtual {v0, v3, v4}, Lokhttp3/internal/http2/Http2Connection$ReaderRunnable;->applyAndAckSettings(ZLokhttp3/internal/http2/Settings;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 576
    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    invoke-virtual {v1, v2}, Ljava/lang/Thread;->setName(Ljava/lang/String;)V

    throw v0
.end method
