!--------------------------------------------------------------------------------------------------!
!  DFTB+: general package for performing fast atomistic simulations                                !
!  Copyright (C) 2006 - 2023  DFTB+ developers group                                               !
!                                                                                                  !
!  See the LICENSE file for terms of usage and distribution.                                       !
!--------------------------------------------------------------------------------------------------!

#:include 'common.fypp'

!> Simple mixer for mixing charges
module dftbp_mixer_simplemixer
  use dftbp_common_accuracy, only : dp
  implicit none

  private
  public :: TSimpleMixer
  public :: init, reset, mix


  !> Contains data for a simple mixer
  type TSimpleMixer
    private

    !> Mixing parameter
    real(dp) :: mixParam

  end type TSimpleMixer


  !> Creates a SimpleMixer instance
  interface init
    module procedure SimpleMixer_init
  end interface


  !> Resets a SimpleMixer
  interface reset
    module procedure SimpleMixer_reset
  end interface


  !> Does the simple mixing
  interface mix
    module procedure SimpleMixer_mix
  end interface

contains


  !> Creates a simple mixer
  subroutine SimpleMixer_init(this, mixParam)

    !> Simple mixer instance on exit
    type(TSimpleMixer), intent(out) :: this

    !> Mixing parameter
    real(dp), intent(in) :: mixParam

    this%mixParam = mixParam

  end subroutine SimpleMixer_init


  !> Resets the mixer
  subroutine SimpleMixer_reset(this, nElem)

    !> Simple mixer instance
    type(TSimpleMixer), intent(inout) :: this

    !> Length of the vectors to mix
    integer, intent(in) :: nElem

    @:ASSERT(nElem > 0)

    continue

  end subroutine SimpleMixer_reset


  !> Does the actual mixing
  subroutine SimpleMixer_mix(this, qInpResult, qDiff)

    !> SimpleMixer instance
    type(TSimpleMixer), intent(inout) :: this

    !> Input charge on entry, mixed charge on exit
    real(dp), intent(inout) :: qInpResult(:)

    !> Charge difference
    real(dp), intent(in) :: qDiff(:)

    @:ASSERT(size(qInpResult) == size(qDiff))

    qInpResult(:) = qInpResult(:) + this%mixParam * qDiff(:)

  end subroutine SimpleMixer_mix

end module dftbp_mixer_simplemixer
