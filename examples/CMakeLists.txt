cmake_minimum_required(VERSION 2.6)

set(CMAKE_C_COMPILER mpicc)
set(CMAKE_CXX_COMPILER mpicxx)

# gp optimization
add_executable(math_opt ./math_opt.cpp)
add_dependencies(math_opt mpo)
target_link_libraries(math_opt mpo)

add_executable(de_opt ./de_opt.cpp)
add_dependencies(de_opt mpo)
target_link_libraries(de_opt mpo)

add_executable(single ./single.cpp)
add_dependencies(single mpo)
target_link_libraries(single mpo)

add_executable(run ./run.cpp)
add_dependencies(run mpo)
target_link_libraries(run mpo)

add_executable(nrun ./nrun.cpp)
add_dependencies(nrun mpo)
target_link_libraries(nrun mpo)

add_executable(config_test ./config_test.cpp)
add_dependencies(config_test mpo)
target_link_libraries(config_test mpo)

