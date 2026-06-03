cmake_minimum_required(VERSION 3.10)
project(KBDTrainer VERSION 1.0)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

if(DEFINED SDL3_DIR)
    find_package(SDL3 REQUIRED HINTS ${SDL3_DIR})
else()
    find_package(SDL3 REQUIRED)
endif()

if(DEFINED SDL3_IMAGE_DIR)
    find_package(SDL3_image REQUIRED HINTS ${SDL3_IMAGE_DIR})
else()
    find_package(SDL3_image REQUIRED)
endif()

if(DEFINED SDL3_TTF_DIR)
    find_package(SDL3_ttf REQUIRED HINTS ${SDL3_TTF_DIR})
else()
    find_package(SDL3_ttf REQUIRED)
endif()


set(HEADER_FILES
    include/input.h
    include/render.h
    include/game.h
)

set(SOURCE_FILES
    src/main.c
    src/input.c
    src/render.c
    src/game.c
)

include_directories(include)

add_executable(${PROJECT_NAME} ${SOURCE_FILES} ${HEADER_FILES})


target_link_libraries(${PROJECT_NAME}
    SDL3::SDL3
    SDL3_image::SDL3_image
    SDL3_ttf::SDL3_ttf
)

if(WIN32)
    target_link_libraries(${PROJECT_NAME} xinput)
endif()


set_target_properties(${PROJECT_NAME} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY           "${CMAKE_SOURCE_DIR}/bin"
    RUNTIME_OUTPUT_DIRECTORY_DEBUG     "${CMAKE_SOURCE_DIR}/bin"
    RUNTIME_OUTPUT_DIRECTORY_RELEASE   "${CMAKE_SOURCE_DIR}/bin"
)


if(WIN32)
    get_target_property(SDL3_DLL_PATH       SDL3::SDL3             IMPORTED_LOCATION)
    get_target_property(SDL3_IMAGE_DLL_PATH SDL3_image::SDL3_image IMPORTED_LOCATION)
    get_target_property(SDL3_TTF_DLL_PATH   SDL3_ttf::SDL3_ttf     IMPORTED_LOCATION)

    add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${SDL3_DLL_PATH}" "${CMAKE_SOURCE_DIR}/bin"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${SDL3_IMAGE_DLL_PATH}" "${CMAKE_SOURCE_DIR}/bin"
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${SDL3_TTF_DLL_PATH}" "${CMAKE_SOURCE_DIR}/bin"
        COMMENT "Copie des DLLs SDL3 dans bin/"
    )
endif()

install(TARGETS ${PROJECT_NAME} DESTINATION bin)
install(DIRECTORY ${CMAKE_SOURCE_DIR}/assets DESTINATION bin)


add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory
        "${CMAKE_SOURCE_DIR}/assets"
        "${CMAKE_SOURCE_DIR}/bin/assets"
    COMMENT "Copie des assets dans bin/"
)