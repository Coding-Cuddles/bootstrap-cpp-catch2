include(FetchContent)

# Find an installed Catch2 v2 package or fetch and verify the pinned release
function(fetch_catch2)
    string(
        CONCAT
        catch2_url
        "https://github.com/catchorg/Catch2/archive/refs/tags/"
        "v2.13.10.tar.gz"
    )
    set(
        catch2_sha256
        d54a712b7b1d7708bc7a819a8e6e47b2fde9536f487b89ccbca295072a7d9943
    )

    FetchContent_Declare(
        Catch2
        URL ${catch2_url}
        URL_HASH SHA256=${catch2_sha256}
        DOWNLOAD_EXTRACT_TIMESTAMP
        FALSE
        FIND_PACKAGE_ARGS
        2...<3
    )
    FetchContent_MakeAvailable(Catch2)
endfunction()
