import logging

class LogHelper():
  run_id: str

  def __init__(self, run_id) -> None:
      self.run_id = run_id 

  def log_info(self, message: str):
      logging.info(f"{self.run_id} - {message}")

  def log_error(self, message: str):
      logging.error(f"{self.run_id} - {message}")
