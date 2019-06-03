cmake_minimum_required(VERSION 3.3)
project(MPO)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -DASCO -std=c++11 -g")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3 -DASCO -std=c++11 -g")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH}
			${CMAKE_CURRENT_SOURCE_DIR}/cmake)

SET(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
SET(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)
SET(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)

# the version number
set(Tutorial_VERSION_MAJOR 1)
set(Tutorial_VERSION_MINOR 0)

# set installation directory
set(CMAKE_INSTALL_PREFIX ${PROJECT_BINARY_DIR})

# APPLE installation related
if(APPLE)
  # For macports or similar systems
  set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} 
	/opt/local/lib /opt/local/Library)
  set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} 
	/opt/local/include /opt/local/Library)
  set(CMAKE_PROGRAM_PATH ${CMAKE_PROGRAM_PATH} 
	/opt/local/bin/ /opt/local/Library)
endif(APPLE)

# BOOST 
find_package(Boost 1.61 COMPONENTS mpi serialization REQUIRED)
if(Boost_FOUND)
	message(STATUS "Boost Found")
	include_directories(${Boost_INCLUDE_DIR})
else()
    message(STATUS "Boost not found")
endif()

# dependency: MPI
find_package(MPI REQUIRED)
if(MPI_FOUND)
    message(STATUS "MPI Found")
    include_directories(${MPI_INCLUDE_PATH})
else()
    message(FATAL_ERROR "MPI not found")
endif()

# prerequisite NLOPT
#find_package(NLopt)
#if(NLOPT_FOUND)
#  message(STATUS "Looking for NLOPT - found")
#  set(HAVE_NLOPT TRUE)
#else(NLOPT_FOUND)
#  message(WARNING "NLOPT not found")
#  set(HAVE_NLOPT FALSE)
#endif()
# find_package(NLOPT)
set(NLOPT_LIB nlopt)

# check if Doxygen is installed
find_package(Doxygen)
option(BUILD_DOC "Build documentation" ON)
if (DOXYGEN_FOUND)
    # set input and output files
    set(DOXYGEN_IN ${CMAKE_CURRENT_SOURCE_DIR}/Doxyfile.in)
    set(DOXYGEN_OUT ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)

    # request to configure the file
    configure_file(${DOXYGEN_IN} ${DOXYGEN_OUT} @ONLY)
    message("Doxygen build started")

    # note the option ALL which allows to build the docs together with the 
    # application
    add_custom_target( doc_doxygen ALL
        COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYGEN_OUT}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/doc
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM )
else (DOXYGEN_FOUND)
  message("Doxygen need to be installed to generate the doxygen documentation")
endif (DOXYGEN_FOUND)

# BayesOpt
add_subdirectory(bayesopt)
set(BAYESOPT_LIB bayesopt)
include_directories(${PROJECT_BINARY_DIR}/bayesopt/include)
include_directories(${PROJECT_BINARY_DIR}/bayesopt/utils)

# inih
set(INIH_PATH ${PROJECT_BINARY_DIR}/inih)
add_custom_target(INIH_MAKE
		  COMMAND cp Makefile.static Makefile
		  WORKING_DIRECTORY ${INIH_PATH}/extra/)
add_custom_command(OUTPUT libinih.a
		  COMMAND make Makefile
		  WORKING_DIRECTORY ${INIH_PATH}/extra/)
set(INIH_LIB ${INIH_PATH}/extra/libinih.a)
include_directories(${INIH_PATH})

# OpenMP
find_package(OpenMP REQUIRED)
if(OPENMP_FOUND)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${OpenMP_EXE_LINKER_FLAGS}")
endif()

# DesignEasy
set(DESIGNEASY_PATH ${PROJECT_BINARY_DIR}/DesignEasy)
set(DESIGNEASY_SOURCECODE_PATH ${DESIGNEASY_PATH}/DesignEasy/SourceCode)
add_subdirectory(${DESIGNEASY_SOURCECODE_PATH})
include_directories(${DESIGNEASY_SOURCECODE_PATH})
#add_custom_target(DE_MAKE
 # 		  COMMAND make
#		  WORKING_DIRECTORY ${DESIGNEASY_SOURCECODE_PATH})
#include_directories(${DESIGNEASY_SOURCECODE_PATH})
#add_library(${DESIGNEASY_SOURCECODE_PATH})
#message(STATUS "test: ${DESIGNEASY_SOURCECODE_PATH}")+

# build
include_directories(${PROJECT_BINARY_DIR}/src)

# build designeasy library
add_library(de_interface STATIC
		${DESIGNEASY_SOURCECODE_PATH}/Auxi.cpp
		${DESIGNEASY_SOURCECODE_PATH}/ReadPara.cpp
		${DESIGNEASY_SOURCECODE_PATH}/Meas.cpp
		${DESIGNEASY_SOURCECODE_PATH}/ReadMeas.cpp
		${DESIGNEASY_SOURCECODE_PATH}/ListGen.cpp
		${DESIGNEASY_SOURCECODE_PATH}/SimGen.cpp
		${DESIGNEASY_SOURCECODE_PATH}/FixWeightEvaluate.cpp
		${DESIGNEASY_SOURCECODE_PATH}/interface.cpp
		./src/deplugin.cpp)
target_link_libraries(de_interface m)

set(mpo_src
#	./src/master.cpp
#	./src/master.hpp
#	./src/slave.cpp
#	./src/slave.hpp
	./src/master1.cpp
	./src/master1.hpp
	./src/slave1.cpp
	./src/slave1.hpp
	./src/node.cpp
	./src/node.hpp
	./src/config.cpp	
	./src/config.hpp
	./src/dataset.cpp
	./src/dataset.hpp
	./src/region.cpp
	./src/region.hpp
	./src/benchmark.cpp
	./src/benchmark.hpp
	./src/optbase.cpp
	./src/optbase.hpp
	./src/optbayes.cpp
	./src/optbayes.hpp
	./src/comm.hpp
	./src/stats.cpp
	./src/stats.hpp
	./src/progressbar.hpp
	./src/utils.cpp
	./src/utils.hpp
	./src/deplugin.cpp
	./src/deplugin.hpp)
add_library(mpo STATIC ${mpo_src})
add_dependencies(mpo
	${BAYESOPT_LIB}
	de_interface)
target_link_libraries(mpo 
	${NLOPT_LIB} 
	${BAYESOPT_LIB} 
	${INIH_LIB} 
	de_interface
	${Boost_LIBRARIES}
	${MPI_LIBRARIES}
	boost_mpi
	boost_serialization)

#add_executable(run
#	./src/mpo.cpp)
#add_dependencies(run
#	mpo)
#target_link_libraries(run
#	mpo)

add_executable(single_test
	${mpo_src}
	./examples/single.cpp)
add_dependencies(single_test
	${BAYESOPT_LIB}
	de_interface)
target_link_libraries(single_test
	${NLOPT_LIB} 
	${BAYESOPT_LIB} 
	${INIH_LIB} 
	de_interface
	${Boost_LIBRARIES}
	${MPI_LIBRARIES}
	boost_mpi
	boost_serialization)

add_library(dataset
	./src/dataset.cpp
	./src/dataset.hpp
	./src/utils.cpp
	./src/utils.hpp)	

add_library(optbase
	./src/optbase.cpp
	./src/optbase.hpp
	./src/dataset.cpp
	./src/dataset.hpp
	./src/utils.cpp
	./src/utils.hpp
	./src/stats.cpp
	./src/stats.hpp)

add_library(optbayes
	./src/optbayes.cpp
	./src/optbayes.hpp)
add_dependencies(optbayes
	optbase)
target_link_libraries(optbayes
	optbase)

add_library(utils
	./src/utils.cpp
	./src/utils.hpp)

add_library(region
	./src/region.cpp
	./src/region.hpp)
add_dependencies(region
	utils
	dataset)
target_link_libraries(region
	utils
	dataset)

add_executable(tester 
			./examples/tester.cpp)
add_dependencies(tester 
	mpo)
target_link_libraries(tester
	mpo)

add_library(master1 
				./src/master1.cpp
				./src/master1.hpp
				./src/node.hpp				
				./src/node.cpp)
add_dependencies(master1
				mpo)
target_link_libraries(master1
				mpo)

add_library(slave1
				./src/slave1.cpp
				./src/slave1.hpp
				./src/node.hpp				
				./src/node.cpp)
add_dependencies(slave1
				mpo)
target_link_libraries(slave1
				mpo)


add_subdirectory(examples)

set(CMAKE_C_COMPILER mpicc)
set(CMAKE_CXX_COMPILER mpicxx)














