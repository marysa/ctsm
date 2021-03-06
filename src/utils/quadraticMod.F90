module quadraticMod

  use abortutils  ,   only: endrun
  use shr_kind_mod,   only: r8 => shr_kind_r8
  use shr_log_mod ,   only: errMsg => shr_log_errMsg
  use clm_varctl  ,   only: iulog

  implicit none

  public :: quadratic

  character(len=*), parameter, private :: sourcefile = &
       __FILE__

contains

  subroutine quadratic (a, b, c, r1, r2)
     !
     ! !DESCRIPTION:
     !==============================================================================!
     !----------------- Solve quadratic equation for its two roots -----------------!
     !==============================================================================!
     ! Solution from Press et al (1986) Numerical Recipes: The Art of Scientific
     ! Computing (Cambridge University Press, Cambridge), pp. 145.
     !
     ! !REVISION HISTORY:
     ! 4/5/10: Adapted from /home/bonan/ecm/psn/An_gs_iterative.f90 by Keith Oleson
     !
     ! !USES:
     implicit none
     !
     ! !ARGUMENTS:
     real(r8), intent(in)  :: a,b,c       ! Terms for quadratic equation
     real(r8), intent(out) :: r1,r2       ! Roots of quadratic equation
     !
     ! !LOCAL VARIABLES:
     real(r8) :: q                        ! Temporary term for quadratic solution
     real(r8) :: root                     ! Term that will have a square root taken
     !------------------------------------------------------------------------------
    
     if (a == 0._r8) then
        write (iulog,*) 'Quadratic solution error: a = ',a
        call endrun(msg=errmsg(sourcefile, __LINE__))
     end if

     root = b*b - 4._r8*a*c
     if ( root < 0.0 )then
        if ( sqrt(-root) > epsilon(b) )then
           root = 0.0_r8
        else
           write (iulog,*) 'Quadratic solution error: b^2 - 4ac is negative = ', root
           call endrun(msg=errmsg(sourcefile, __LINE__))
        end if
     end if
   
     if (b >= 0._r8) then
        q = -0.5_r8 * (b + sqrt(root))
     else
        q = -0.5_r8 * (b - sqrt(root))
     end if
   
     r1 = q / a
     if (q /= 0._r8) then
        r2 = c / q
     else
        r2 = 1.e36_r8
     end if

  end subroutine quadratic

end module quadraticMod
