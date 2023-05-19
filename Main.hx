import haxe.Json;
import org.msgpack.MsgPack;
import sys.FileSystem;
import sys.io.File;
using StringTools;
using haxe.io.Path;

function exit(?msg:String, code=1) {
    if(msg != null) Sys.stderr().writeString('$msg\n');
    Sys.exit(1);
}

inline function usage(?msg:String, code=1)
    exit("Usage: msgpack <file.json|file.msgpack>\n",1);

function main() {
    var args = Sys.args();
    if(args.length != 1)
        usage();
    final file = args[0].trim();
    switch file {
    case "--help","-h": usage();
    case _:
        if(!FileSystem.exists(file))
            usage('file not found');
        switch file.extension() {
        case "json":
            var encoded = MsgPack.encode(Json.parse(File.getContent(file)));
            Sys.stdout().writeBytes(encoded, 0, encoded.length);
            /*
            File.saveBytes(
                file.withoutExtension()+'.msgpack',
                MsgPack.encode(Json.parse(File.getContent(file)))
            );
            */
        case "msgpack":
            var json = Json.stringify(MsgPack.decode(File.getBytes(file)));
            Sys.stdout().writeString(json);
            /*
            File.saveContent(
                file.withoutExtension()+'.json',
                Json.stringify(MsgPack.decode(File.getBytes(file)))
            );
            */
        case _:
            usage('unknown filetype');
        }
    }
}
