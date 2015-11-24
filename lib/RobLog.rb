=begin
@author     Robert Waffen <rwaffen@gmail.com>

This class provides a logger from the gem "logging".
The logger writes to STDOUT and a file.
=end

class RobLog

  #@param name String
  #@return logger Logging
  def get_logger(name)
    logger = Logging.logger[name]
    logger.add_appenders(
        Logging.appenders.file('wallcollage.log', :layout => Logging.layouts.pattern(:pattern => '[%d] %-7l | %-15c | %m\n')),
        Logging.appenders.stdout(:layout => Logging.layouts.pattern(:pattern => '[%d] %-7l | %-15c | %m\n'))
    )
    logger.level = :info

    return logger
  end
end